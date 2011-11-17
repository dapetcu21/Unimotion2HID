//
//  HIDKeyboard.h
//
//  Created by Marius Petcu on 11/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HIDKeyboard : NSObject {
	BOOL up,down,left,right,enabled;
}

-(void)sendEvents:(NSArray*)events up:(BOOL)iup down:(BOOL)idown left:(BOOL)ileft right:(BOOL)iright;

@end
