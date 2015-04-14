//
//  AppDelegate.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 08.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var settingsWindow: NSWindow!
    @IBOutlet weak var aboutWindow: NSWindow!
    
    var statusItem: NSStatusItem!
    var statusMenu: NSMenu!
    
    var mikeyListener: MikeyListener?
    var bluetoothListener: BluetoothListener?

    // MARK: - Notifications
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.settingsWindow.orderOut(self)
        self.aboutWindow.orderOut(self)
        
        mikeyListener = MikeyListener()
        bluetoothListener = BluetoothListener()
        
        // Unload rcd
        NSTask.launchedTaskWithLaunchPath("/bin/launchctl", arguments: ["unload","/System/Library/LaunchAgents/com.apple.rcd.plist"])
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Load rcd again
        NSTask.launchedTaskWithLaunchPath("/bin/launchctl", arguments: ["load", "/System/Library/LaunchAgents/com.apple.rcd.plist"])
    }
    
    // MARK: - Nib Handling
    
    override func awakeFromNib() {
        // TODO: this should use 'NSVariableStatusItemLength' instead of -1, but currently this causes a linker error
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
        statusItem.image = NSImage(named: "MenuIcon")
        statusItem.image?.setTemplate(true)
        statusItem.highlightMode = true
        
        statusMenu = NSMenu(title: "statusBarMenu")
        statusMenu.addItemWithTitle("Settings", action: Selector("showSettings"), keyEquivalent: "")
        statusMenu.addItemWithTitle("About", action: Selector("showAbout"), keyEquivalent: "")
        statusMenu.addItem(NSMenuItem.separatorItem())
        statusMenu.addItemWithTitle("Exit", action: Selector("exitApp"), keyEquivalent: "")
        
        statusItem.menu = statusMenu
    }
    
    // MARK: - Actions
    
    func showSettings() {
        self.settingsWindow.makeKeyAndOrderFront(self)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    func showAbout() {
        self.aboutWindow.makeKeyAndOrderFront(self)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    func exitApp() {
        NSApplication.sharedApplication().terminate(self)
    }

}

