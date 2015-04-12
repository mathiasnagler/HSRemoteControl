//
//  HSRemoteController.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 08.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Cocoa
import IOKit

enum Mikey: UInt32 {
    case PlayPause  = 137
    case Next       = 138
    case Prev       = 139
    case Up         = 140
    case Down       = 141
    
    func description() -> String {
        switch self {
        case PlayPause:
            return "PlayPause"
        case Next:
            return "Next"
        case Prev:
            return "Prev"
        case .Up:
            return "Up"
        case .Down:
            return "Down"
        }
    }
}

class MikeyListener: NSObject {
    
    // MARK: - Properties
    
    var miKeys: Array<DDHidAppleMikey> = Array<DDHidAppleMikey>()

    // MARK: - Initialization
    
    override init() {
        
        super.init()

        if let tmpMiKeys = DDHidAppleMikey.allMikeys() as? Array<DDHidAppleMikey> {
            for miKey in tmpMiKeys {
                miKeys.append(miKey)
            }
        }
        miKeys.map { $0.setDelegate(self) }

        startListening()
    }
    
    // MARK: - Public
    
    func startListening() {
        miKeys.map { $0.startListening() }
    }
    
    func stopListening() {
        miKeys.map { $0.stopListening() }
    }
    
    // MARK: - DDHidAppleMikeyDelegate
    
    override func ddhidAppleMikey(mikey: DDHidAppleMikey!, press usageId: UInt32, upOrDown: Bool) {
        if let mikeyButton = Mikey(rawValue: usageId) {
            
            if !upOrDown {
                return
            }
            
            switch mikeyButton {
            case .PlayPause:
                MediaKey.send(NX_KEYTYPE_PLAY)
            case .Next:
                MediaKey.send(NX_KEYTYPE_FAST)
            case .Prev:
                MediaKey.send(NX_KEYTYPE_REWIND)
            default:
                break
            }


        }
    }
    
}
