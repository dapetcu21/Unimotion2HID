//
//  HIDKeyboard.m
//
//  Created by Marius Petcu on 11/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HIDKeyboard.h"
#import "KeyEventView.h"

void inline postEvent(CGEventRef event)
{
	if (event)
	{
		CGEventPost(kCGHIDEventTap,event);
	}
}

@implementation HIDKeyboard
-(void)awakeFromNib
{
	up=down=left=right=NO;
}

-(void)sendEvents:(NSArray*)events up:(BOOL)iup down:(BOOL)idown left:(BOOL)ileft right:(BOOL)iright
{
	/*NSLog(@"OLD: up:%d down:%d left:%d right:%d NEW: up:%d down:%d left:%d right:%d"
		  ,(int)up
		  ,(int)down
		  ,(int)left
		  ,(int)right
		  ,(int)iup
		  ,(int)idown
		  ,(int)ileft
		  ,(int)iright
		  );*/
	if (up&&(!iup))
		postEvent([(KeyEventView*)[events objectAtIndex:0] upEvent]);
	if ((!up)&&(iup))
		postEvent([(KeyEventView*)[events objectAtIndex:0] downEvent]);
	
	if (down&&(!idown))
		postEvent([(KeyEventView*)[events objectAtIndex:1] upEvent]);
	if ((!down)&&(idown))
		postEvent([(KeyEventView*)[events objectAtIndex:1] downEvent]);
	
	if (left&&(!ileft))
		postEvent([(KeyEventView*)[events objectAtIndex:2] upEvent]);
	if ((!left)&&(ileft))
		postEvent([(KeyEventView*)[events objectAtIndex:2] downEvent]);
	
	if (right&&(!iright))
		postEvent([(KeyEventView*)[events objectAtIndex:3] upEvent]);
	if ((!right)&&(iright))
		postEvent([(KeyEventView*)[events objectAtIndex:3] downEvent]);
	up=iup;
	down=idown;
	left=ileft;
	right=iright;
}

@end
