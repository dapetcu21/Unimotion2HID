//
//  SMSController.m
//
//  Created by Marius Petcu on 9/24/09.
//  Copyright 2009 SmartSoftware. All rights reserved.
//
/*
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import "SMSController.h"
#import "unimotion.h"
#import <math.h>

#define FINE_TUNE_X (1.05882353)
#define FINE_TUNE_Y (1.0909090909090909090909090909090909)

@implementation SMSController

- (void) awakeFromNib
{
	mtype=detect_sms();
}

- (NSPoint) funkyMathWithX:(double)ax Y:(double)ay Z:(double)az
{
	NSPoint result;
	result.x=(double)(atan(ax/sqrt(ay*ay+az*az))*M_2_PI*90*FINE_TUNE_X);
	result.y=(double)(atan(ay/sqrt(ax*ax+az*az))*M_2_PI*90*FINE_TUNE_Y);
	if (az<0)
	{
		if (result.x<0)
			result.x=-180-result.x;
		else
			result.x=180-result.x;
		
		if (result.y<0)
			result.y=-180-result.y;
		else
			result.y=180-result.y;
	}
	return result;
}

-(NSPoint) filterWithNew:(NSPoint)new andOld:(NSPoint)old
{
	NSPoint res;
	res.x=(new.x+old.x)/2;
	res.y=(new.y+old.y)/2;
	return res;
}

- (SMSOutput) accelDataWithArgs:(SMSInput)ins
{
	double xraw=0,yraw=0,zraw=0,tmpx,tmpy,tmpz;
	read_sms_real(mtype,&xraw,&yraw,&zraw);
	SMSOutput result;
	result.rawx=xraw;
	result.rawy=yraw;
	result.rawz=zraw;
	tmpx=xraw;
	tmpy=yraw;
	tmpz=zraw;
	switch (ins.mapx) {
		case 0:
			xraw=tmpx;
			break;
		case 1:
			xraw=tmpy;
			break;
		case 2:
			xraw=tmpz;
			break;
		default:
			break;
	}
	switch (ins.mapy) {
		case 0:
			yraw=tmpx;
			break;
		case 1:
			yraw=tmpy;
			break;
		case 2:
			yraw=tmpz;
			break;
		default:
			break;
	}
	switch (ins.mapz) {
		case 0:
			zraw=tmpx;
			break;
		case 1:
			zraw=tmpy;
			break;
		case 2:
			zraw=tmpz;
			break;
		default:
			break;
	}
	NSPoint xandy = [self funkyMathWithX:xraw Y:yraw Z:zraw];
	NSPoint tmp=xandy;
	if (ins.filter)
		xandy=[self filterWithNew:xandy andOld:olddata];
	olddata=tmp;
	xandy.x*=ins.sensitx;
	xandy.y*=ins.sensity;
	result.x=xandy.x;
	result.y=xandy.y;
	if (ins.invx)
		result.x=-result.x;
	if (ins.invy)
		result.y=-result.y;
	result.xnodz=result.x;
	result.ynodz=result.y;
	float scale,add;
	if ((result.x<=ins.dzX1)&&(ins.dzX2<=result.x))
		result.x=(ins.dzX1+ins.dzX2)/2;
	else {
		switch (ins.dzXmod) {
			case 1:
				if (result.x<ins.dzX2)
				{
					result.x+=(ins.dzX1-ins.dzX2)/2;
				} else {
					result.x-=(ins.dzX1-ins.dzX2)/2;
				}
				break;
			case 2:
				if (result.x<ins.dzX2)
				{
					scale=((ins.dzX1+ins.dzX2)/2-(-180))/(ins.dzX2-(-180));
					add=(-180)-(-180)*scale;
					result.x=result.x*scale+add;
				} else {
					scale=(180-(ins.dzX1+ins.dzX2)/2)/(180-ins.dzX1);
					add=(180)-(180)*scale;
					result.x=result.x*scale+add;
				}
				break;
			default:
				break;
		};
	}
	
	if ((result.y<=ins.dzY1)&&(ins.dzY2<=result.y))
		result.y=(ins.dzY1+ins.dzY2)/2;
	else {
		switch (ins.dzYmod) {
			case 1:
				if (result.y<ins.dzY2)
				{
					result.y+=(ins.dzY1-ins.dzY2)/2;
				} else {
					result.y-=(ins.dzY1-ins.dzY2)/2;
				}
				break;
			case 2:
				if (result.y<ins.dzY2)
				{
					scale=((ins.dzY1+ins.dzY2)/2-(-180))/(ins.dzY2-(-180));
					add=(-180)-(-180)*scale;
					result.y=result.y*scale+add;
				} else {
					scale=(180-(ins.dzY1+ins.dzY2)/2)/(180-ins.dzY1);
					add=(180)-(180)*scale;
					result.y=result.y*scale+add;
				}
				break;
			default:
				break;
		};
	}
	return result;
}

@end
