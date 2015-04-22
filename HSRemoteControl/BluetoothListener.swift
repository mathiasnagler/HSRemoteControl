//
//  BluetoothListener.swift
//  HSRemoteControl
//
//  Created by Tobias Becker on 12.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Foundation
import AppKit

enum BluetoothButton: Int {
    case Play       = 205
    case Next       = 181
    case Previous   = 182
    
    func description() -> String {
        switch self {
        case .Play:
            return "Play"
        case .Next:
            return "Next"
        case .Previous:
            return "Previous"
        }
    }
}

class BluetoothListener {
    
    // MARK: - Properties
    
    var eventMonitor: AnyObject?
    
    // MARK: - Public
    
    func startListening() {
        // TODO: Find reason for occasional delay
        eventMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask | NSEventMask.SystemDefinedMask, handler: self.eventHandler)
    }
    
    func stopListening() {
        // TODO: Implement stopListening
    }
    
    // MARK: - Private
    
    private func eventHandler(event: NSEvent?) {
        
        if let event = event {
            if let keyType = BluetoothButton(rawValue: event.data2 & 0x0000FFFF) {
                
                println("\(keyType.description()) event detected")
                
                switch keyType {
                case .Play:
                    MediaKey.send(NX_KEYTYPE_PLAY)
                case .Next:
                    MediaKey.send(NX_KEYTYPE_FAST)
                case .Previous:
                    MediaKey.send(NX_KEYTYPE_REWIND)
                }
            }
        }
    
    }
    
}