//
//  MediaApplications.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 22.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Foundation

enum MediaApplication {
    case ITunes
    case Spotify
    case QuickTimePlayerX
    case QuickTimePlayer
    case Keynote
    case IPhoto
    case VLC
    case Aperture
    case Plex
    case SoundcloundDesktop
    case MPlayerX
    
    func bundleIdentifier() -> String {
        switch self {
        case .ITunes:
            return "com.apple.iTunes"
        case .Spotify:
            return "com.spotify.client"
        case .QuickTimePlayerX:
            return "com.apple.QuickTimePlayerX"
        case .QuickTimePlayer:
            return "com.apple.quicktimeplayer"
        case .Keynote:
            return "com.apple.iWork.Keynote"
        case .IPhoto:
            return "com.apple.iPhoto"
        case .VLC:
            return "org.videolan.vlc"
        case .Aperture:
            return "com.apple.Aperture"
        case .Plex:
            return "com.plexsquared.Plex"
        case .SoundcloundDesktop:
            return "com.soundcloud.desktop"
        case .MPlayerX:
            return "org.niltsh.MPlayerX"
        }
    }
    
    func isAppleApp() -> Bool {
        if self.bundleIdentifier().rangeOfString("com.apple") != nil {
            return true
        }
        return false
    }
}

