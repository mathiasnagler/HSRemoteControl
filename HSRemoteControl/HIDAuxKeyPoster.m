//
//  HIDAuxKeyPoster.m
//  HSRemoteControl
//
//  Created by Mathias Nagler on 10.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

#import "HIDAuxKeyPoster.h"
#import <Cocoa/Cocoa.h>
#import <IOKit/hidsystem/IOHIDLib.h>
#import <IOKit/hidsystem/ev_keymap.h>

@implementation HIDAuxKeyPoster

static io_connect_t get_event_driver(void)
{
    static  mach_port_t sEventDrvrRef = 0;
    mach_port_t masterPort, service, iter;
    kern_return_t    kr;
    
    if (!sEventDrvrRef)
    {
        // Get master device port
        kr = IOMasterPort( bootstrap_port, &masterPort );
        check( KERN_SUCCESS == kr);
        
        kr = IOServiceGetMatchingServices( masterPort, IOServiceMatching( kIOHIDSystemClass ), &iter );
        check( KERN_SUCCESS == kr);
        
        service = IOIteratorNext( iter );
        check( service );
        
        kr = IOServiceOpen( service, mach_task_self(),
                           kIOHIDParamConnectType, &sEventDrvrRef );
        check( KERN_SUCCESS == kr );
        
        IOObjectRelease( service );
        IOObjectRelease( iter );
    }
    return sEventDrvrRef;
}

+ (void)HIDPostAuxKey:(UInt8)auxKeyCode
{
    NXEventData   event;
    kern_return_t kr;
    IOGPoint      loc = { 0, 0 };
    
    // Key press event
    UInt32      evtInfo = auxKeyCode << 16 | NX_KEYDOWN << 8;
    bzero(&event, sizeof(NXEventData));
    event.compound.subType = NX_SUBTYPE_AUX_CONTROL_BUTTONS;
    event.compound.misc.L[0] = evtInfo;
    kr = IOHIDPostEvent( get_event_driver(), NX_SYSDEFINED, loc, &event, kNXEventDataVersion, 0, FALSE );
    check( KERN_SUCCESS == kr );
    
    // Key release event
    evtInfo = auxKeyCode << 16 | NX_KEYUP << 8;
    bzero(&event, sizeof(NXEventData));
    event.compound.subType = NX_SUBTYPE_AUX_CONTROL_BUTTONS;
    event.compound.misc.L[0] = evtInfo;
    kr = IOHIDPostEvent( get_event_driver(), NX_SYSDEFINED, loc, &event, kNXEventDataVersion, 0, FALSE );
    check( KERN_SUCCESS == kr );
}

@end
