//
//  MediaKey.m
//  HeadsetRemoteListener
//
//  Created by Tobias Becker on 09.04.15.
//  Copyright (c) 2015 Tobias Becker. All rights reserved.
//

#import "MediaKey.h"

@import AppKit;

@implementation MediaKey

+ (void)send:(int)key {
    
    // create key events
    NSInteger downKey = ((key << 16) | (0xa << 8));
    NSInteger upKey = ((key << 16) | (0xb << 8));
    
    // create and send down key event
    NSEvent *key_event = [NSEvent otherEventWithType:NSSystemDefined location:CGPointZero modifierFlags:0xa00 timestamp:0 windowNumber:0 context:0 subtype:8 data1:downKey data2:-1];
    CGEventPost(0, key_event.CGEvent);
    
    // create and send up key event
    key_event = [NSEvent otherEventWithType:NSSystemDefined location:CGPointZero modifierFlags:0xb00 timestamp:0 windowNumber:0 context:0 subtype:8 data1:upKey data2:-1];
    CGEventPost(0, key_event.CGEvent);
}

@end
