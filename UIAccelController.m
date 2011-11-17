//
//  UIAccelController.m
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
#import "UIAccelController.h"
#import "HIDMouse.h"
#import "HIDKeyboard.h"

@implementation UIAccelController

-(void) awakeFromNib
{
	[SensitivityX setFloatValue:1.0];
	[SensitivityY setFloatValue:1.0];
	[mapX selectItemAtIndex:0];
	[mapY selectItemAtIndex:1];
	[mapZ selectItemAtIndex:2];
	movemouse=false;
	[mouseon setState:NSOffState];
	[invX setState:NSOnState];
	[invY setState:NSOffState];
	[self statechange:self];
	timer=nil;
	[self setRefreshRate:self];
	events=[[NSArray alloc] initWithObjects:upK,downK,leftK,rightK,nil];
}

-(void)dealloc
{
	[events release];
	[super dealloc];
}

-(IBAction) setRefreshRate:(id)sender
{
	refreshRate=1/[refreshRatet floatValue];
	if (timer)
	{
		[timer invalidate];
		timer=nil;
		
	}
	timer=[NSTimer scheduledTimerWithTimeInterval:refreshRate target:self selector: @selector(refresh:) userInfo:nil repeats:YES];
}

-(IBAction) statechange:(id)sender
{
	if (sender==dzXSl1)
	{
		if ([dzXSl2 floatValue]>[dzXSl1 floatValue])
			[dzXSl2 setFloatValue:[dzXSl1 floatValue]];
	}
	if (sender==dzXSl2)
	{
		if ([dzXSl2 floatValue]>[dzXSl1 floatValue])
			[dzXSl1 setFloatValue:[dzXSl2 floatValue]];
	}
	if (sender==dzYSl1)
	{
		if ([dzYSl2 floatValue]>[dzYSl1 floatValue])
			[dzYSl2 setFloatValue:[dzYSl1 floatValue]];
	}
	if (sender==dzYSl2)
	{
		if ([dzYSl2 floatValue]>[dzYSl1 floatValue])
			[dzYSl1 setFloatValue:[dzYSl2 floatValue]];
	}	
	ins.sensitx=[SensitivityX floatValue];
	ins.sensity=[SensitivityY floatValue];
	[sensXt setFloatValue:ins.sensitx];
	[sensYt setFloatValue:ins.sensity];
	ins.mapx=[mapX indexOfSelectedItem];
	ins.mapy=[mapY indexOfSelectedItem];
	ins.mapz=[mapZ indexOfSelectedItem];
	ins.invx=([invX state]==NSOnState);
	ins.invy=([invY state]==NSOnState);
	ins.filter=([filteron state]==NSOnState);
	movemouse=([mouseon state]==NSOnState);
	ins.dzX1=[dzXSl1 floatValue];
	ins.dzX2=[dzXSl2 floatValue];
	ins.dzY1=[dzYSl1 floatValue];
	ins.dzY2=[dzYSl2 floatValue];
	ins.dzXmod=[dzXMode indexOfSelectedItem];
	ins.dzYmod=[dzYMode indexOfSelectedItem];
	[dzXSl1t setFloatValue:ins.dzX1];
	[dzXSl2t setFloatValue:ins.dzX2];
	[dzYSl1t setFloatValue:ins.dzY1];
	[dzYSl2t setFloatValue:ins.dzY2];
	upSlV = [upSl floatValue];
	downSlV = [downSl floatValue];
	leftSlV = [leftSl floatValue];
	rightSlV = [rightSl floatValue];
	pxlSkip = [skipPixels indexOfSelectedItem];
	if (movemouse)
		[mousecontroller awakeFromNib];
	if ([mouseSensit1 state]==NSOnState) {
		mouseSensit=0;
	} else {
		if ([mouseSensit2 state]==NSOnState) {
			mouseSensit=[mouseSensitt intValue];
		}
	}
	enableKeys= ([enableKeysB state] == NSOnState);
}

-(IBAction) refresh:(id)sender
{
	SMSOutput outs = [smscontroller accelDataWithArgs:ins];
	[rawOutX setFloatValue:outs.rawx];
	[rawOutY setFloatValue:outs.rawy];
	[rawOutZ setFloatValue:outs.rawz];
	[outX1 setFloatValue:outs.x];
	[outY1 setFloatValue:outs.y];
	[outX2 setFloatValue:outs.xnodz];
	[outY2 setFloatValue:outs.ynodz];
	[outX3 setFloatValue:outs.xnodz];
	[outY3 setFloatValue:outs.ynodz];
	if (movemouse)
		[(HIDMouse *)mousecontroller moveMousetofloatX:outs.x andfloatY:outs.y pixelSkip:pxlSkip sensit:mouseSensit];
	BOOL up=NO,down=NO,left=NO,right=NO;
	if (enableKeys)
	{
		up=(outs.y<=upSlV);
		down=(outs.y>=downSlV);
		left=(outs.x<=leftSlV);
		right=(outs.x>=rightSlV);
	}
	[(HIDKeyboard *)keyboardcontroller sendEvents:events up:up down:down left:left right:right];
}

@end
