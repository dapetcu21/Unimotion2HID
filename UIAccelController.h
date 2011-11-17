//
//  UIAccelController.h
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

#import <Cocoa/Cocoa.h>
#import "KeyEventView.h"

@interface UIAccelController : NSObject {
    IBOutlet NSWindow *window;
    IBOutlet id smscontroller;
	IBOutlet id mousecontroller;
	IBOutlet id keyboardcontroller;
    IBOutlet NSSlider *SensitivityX;
    IBOutlet NSSlider *SensitivityY;
    IBOutlet NSPopUpButton *mapX;
    IBOutlet NSPopUpButton *mapY;
    IBOutlet NSPopUpButton *mapZ;
    IBOutlet NSTextField *outX1;
    IBOutlet NSTextField *outY1;
	IBOutlet NSTextField *outX2;
    IBOutlet NSTextField *outY2;
	IBOutlet NSSlider *outX3;
    IBOutlet NSSlider *outY3;
    IBOutlet NSTextField *rawOutX;
    IBOutlet NSTextField *rawOutY;
    IBOutlet NSTextField *rawOutZ;
	IBOutlet NSButton *mouseon;
	IBOutlet NSPopUpButton *skipPixels;
	IBOutlet NSButton *invX;
	IBOutlet NSButton *invY;
	IBOutlet NSButton *filteron;
 	IBOutlet NSPopUpButton *dzXMode;
	IBOutlet NSPopUpButton *dzYMode;
	IBOutlet NSSlider *dzXSl1;
	IBOutlet NSSlider *dzXSl2;
	IBOutlet NSSlider *dzYSl1;
	IBOutlet NSSlider *dzYSl2;
	
	IBOutlet NSTextField *dzXSl1t;
	IBOutlet NSTextField *dzXSl2t;
	IBOutlet NSTextField *dzYSl1t;
	IBOutlet NSTextField *dzYSl2t;
	IBOutlet NSTextField *sensXt;
	IBOutlet NSTextField *sensYt;
	
	IBOutlet NSTextField *refreshRatet;
	
	IBOutlet NSButtonCell *mouseSensit1,*mouseSensit2;
	IBOutlet NSTextField *mouseSensitt;
	
	IBOutlet NSSlider * upSl;
	IBOutlet NSSlider * downSl;
	IBOutlet NSSlider * leftSl;
	IBOutlet NSSlider * rightSl;
	
	float upSlV,downSlV,leftSlV,rightSlV;
	
	IBOutlet KeyEventView * upK;
	IBOutlet KeyEventView * downK;
	IBOutlet KeyEventView * leftK;
	IBOutlet KeyEventView * rightK;
	
	IBOutlet NSButton * enableKeysB;
	BOOL enableKeys;
	
	NSTimer *timer;
	
	NSArray * events;
	
	float refreshRate;
	BOOL movemouse;
	SMSInput ins;
	int pxlSkip;
	int mouseSensit;
	
}

-(IBAction) refresh:(id)sender;
-(IBAction) statechange:(id)sender;
-(IBAction) setRefreshRate:(id)sender;

@end
