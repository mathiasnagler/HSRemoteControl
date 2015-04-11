//
//  TestApplication.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 10.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Foundation

class HSRemoteControlApplication: NSApplication {
    
    override func sendEvent(theEvent: NSEvent) {
//        if theEvent.type == NSEventType.SystemDefined {
//            println(theEvent)
//        }

        super.sendEvent(theEvent)
    }
    
}
