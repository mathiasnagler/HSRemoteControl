//
//  MediaApplications.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 22.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Foundation

enum MediaApplication: String {
    case ITunes             = "com.apple.iTunes"
    case Spotify            = "com.spotify.client"
    case QuickTimePlayerX   = "com.apple.QuickTimePlayerX"
    case QuickTimePlayer    = "com.apple.quicktimeplayer"
    case Keynote            = "com.apple.iWork.Keynote"
    case IPhoto             = "com.apple.iPhoto"
    case VLC                = "org.videolan.vlc"
    case Aperture           = "com.apple.Aperture"
    case Plex               = "com.plexsquared.Plex"
    case SoundcloundDesktop = "com.soundcloud.desktop"
    case MPlayerX           = "org.niltsh.MPlayerX"
    
    var bundleIdentifier: String {
        get {
            return self.rawValue
        }
    }
    
    func isAppleApp() -> Bool {
        if self.bundleIdentifier.rangeOfString("com.apple") != nil {
            return true
        }
        return false
    }
}

