//
//  HIDMouse.m
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

#import "HIDMouse.h"

@implementation HIDMouse

-(void) awakeFromNib
{
	opt.x=0;
	opt.y=0;
	screen = [[NSScreen mainScreen] frame];
}


-(void) moveMousetofloatX:(float)ix andfloatY:(float)iy pixelSkip:(int)pskip sensit:(int)msensit
{
	CGPoint pt,offset,total;
	pt.x=screen.size.width/180*ix;
	pt.y=screen.size.height/180*iy;
	if (msensit)
	{
		pt.x=msensit/180*ix;
		pt.y=msensit/180*iy;
	}
	CGEventRef ourEvent = CGEventCreate(NULL);
	offset = CGEventGetLocation(ourEvent);
	offset.x+=-opt.x;
	offset.y+=-opt.y;
	CFRelease(ourEvent);
	total.x=offset.x+pt.x;
	total.y=offset.y+pt.y;
	//NSLog(@"Mouse at x:%d y:%d",(int)offset.x,(int)offset.y);
	//[ourEvent release];
	if (abs((int)pt.x-(int)opt.x)+abs((int)pt.y-(int)opt.y)>=pskip)
	{
		NSLog(@"Mouse at x:%d y:%d",(int)total.x,(int)total.y);
		CGEventRef evnt = CGEventCreateMouseEvent(NULL,kCGEventMouseMoved,total,0);
		CGEventSetIntegerValueField(evnt,kCGMouseEventDeltaX,(int)pt.x-(int)opt.x);
		CGEventSetIntegerValueField(evnt,kCGMouseEventDeltaY,(int)pt.y-(int)opt.y);
		CGEventPost(kCGHIDEventTap,evnt);
		CFRelease(evnt);
		//CGPostMouseEvent(total,1,1,0);
	};
	opt=pt;
}

@end
