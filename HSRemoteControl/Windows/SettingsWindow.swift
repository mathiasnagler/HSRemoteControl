//
//  SettingsWindow.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 14.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import AppKit
import ServiceManagement

enum Settings: String {
    case LaunchOnLogin = "LaunchOnLogin"
}

class SettingsWindow: NSWindow {
    
    // MARK: - Properties
    
    @IBOutlet weak var launchAtLoginButton: NSButton!
    
    // MARK: - NSNibAwakening
    
    override func awakeFromNib() {
        let launchAuto = NSUserDefaults.standardUserDefaults().boolForKey(Settings.LaunchOnLogin.rawValue)
        launchAtLoginButton.state = launchAuto ? NSOnState : NSOffState
    }
    
    // MARK: - IBActions
    
    @IBAction func launchAtLoginButtonToggled(sender: NSButton) {
        let launchAuto = sender.state == NSOnState ? true : false
        NSUserDefaults.standardUserDefaults().setValue(launchAuto, forKey: Settings.LaunchOnLogin.rawValue)
        
        if launchAuto {
            // Turn on launch at login
            if !SMLoginItemSetEnabled("de.mathiasnagler.HSRemoteControlLaunchHelper" as CFString, true) {
                println("Error enabling LoginItem")
                // TODO: Handle error
            }
        } else {
            // Turn off launch at login
            if !SMLoginItemSetEnabled("de.mathiasnagler.HSRemoteControlLaunchHelper" as CFString, false) {
                println("Error disabling LoginItem")
                // TODO: Handle error
            }
        }
    }
    
}
