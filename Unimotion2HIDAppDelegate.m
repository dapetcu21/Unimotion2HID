//
//  Unimotion2HIDAppDelegate.m
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

#import "Unimotion2HIDAppDelegate.h"

@implementation Unimotion2HIDAppDelegate

-(BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

-(IBAction) showAboutPanel:(id)sender
{
	NSBeginAlertSheet(@"About Unimotion2HID",
					  nil,nil,nil,window,nil,NULL,NULL,nil,
					  @"Version 0.6\nUnimotion2HID is open-source under GNU GPLv2. If you bought this you where scamed.\nCopyright \u00a9 2009 Marius Petcu"
					  );
}
@end
