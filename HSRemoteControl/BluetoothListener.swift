//
//  BluetoothListener.swift
//  HSRemoteControl
//
//  Created by Tobias Becker on 12.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Foundation
import AppKit

let BT_PLAY = 205
let BT_NEXT = 181
let BT_PREVIOUS = 182

class BluetoothListener : NSObject {
    
    var eventMonitor : AnyObject? = nil
    
    override init() {
        super.init()
        
        startListening()
    }
    
    func startListening() {
        // TODO: Find reason for occasional delay
        eventMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask | NSEventMask.SystemDefinedMask, handler: self.eventHandler)!
    }
    
    func eventHandler (event: (NSEvent!)) -> Void {
        
        let keyType = event.data2 & 0x0000FFFF

        switch keyType {
        case BT_PLAY:
            println("\"play\" event detected")
            // TODO: Why doesn't HIDAuxKeyPoster work here??
            // HIDAuxKeyPoster.HIDPostAuxKey(UInt8(NX_KEYTYPE_PLAY));
            MediaKey.send(NX_KEYTYPE_PLAY)
        case BT_NEXT:
            println("\"next\" event detected")
            // TODO: Why doesn't HIDAuxKeyPoster work here??
            // HIDAuxKeyPoster.HIDPostAuxKey(UInt8(NX_KEYTYPE_FAST));
            MediaKey.send(NX_KEYTYPE_FAST)
        case BT_PREVIOUS:
            println("\"previous\" event detected")
            // TODO: Why doesn't HIDAuxKeyPoster work here??
            // HIDAuxKeyPoster.HIDPostAuxKey(UInt8(NX_KEYTYPE_REWIND));
            MediaKey.send(NX_KEYTYPE_REWIND)
        default:
            break
        }
    }
    
}