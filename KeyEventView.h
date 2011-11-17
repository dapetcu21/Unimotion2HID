//
//  KeyEventView.h
//
//  Created by Marius Petcu on 11/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KeyEventView : NSView {
	CGEventRef upEvent,downEvent;
	NSCell * mycell;
	CGEventSourceRef source;ssss
}

-(IBAction)clear:(id)sender;
-(CGEventRef)upEvent;
-(CGEventRef)downEvent;
-(void)setEvent:(CGEventRef)event;

@end
