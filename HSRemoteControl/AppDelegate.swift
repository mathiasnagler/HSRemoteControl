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
    
    var customEventhandlingEnabled: Bool = false

    // MARK: - Notifications
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.settingsWindow.orderOut(self)
        self.aboutWindow.orderOut(self)
        
        // Initializes Key Listeners
        mikeyListener = MikeyListener()
        bluetoothListener = BluetoothListener()
        
        // Register for notification to track active app
        NSWorkspace.sharedWorkspace().notificationCenter.addObserver(self, selector: "workspaceDidActivateApplication:", name: NSWorkspaceDidActivateApplicationNotification, object: nil)
        
        // TODO: Do not enable if any apple media app is running
        enableCustomEventHandling(true)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Load rcd again
        NSTask.launchedTaskWithLaunchPath("/bin/launchctl", arguments: ["load", "/System/Library/LaunchAgents/com.apple.rcd.plist"])
        
        // Remove self from notificationcenter
        NSWorkspace.sharedWorkspace().notificationCenter.removeObserver(self)
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
    
    // MARK: - Notifications
    
    func workspaceDidActivateApplication(notification: NSNotification) {
        if let
            userInfo = notification.userInfo,
            application = userInfo[NSWorkspaceApplicationKey] as? NSRunningApplication,
            bundleIdentifier = application.bundleIdentifier,
            mediaApplication = MediaApplication(rawValue: bundleIdentifier)
        {
            enableCustomEventHandling(!mediaApplication.isAppleApp())
        }
        
    }
    
    // MARK: - Private
    
    private func enableCustomEventHandling(enabled: Bool) {
        if enabled && !customEventhandlingEnabled{
            // Enable KeyListeners
            mikeyListener?.startListening()
            bluetoothListener?.startListening()
            
            // Unload rcd
            NSTask.launchedTaskWithLaunchPath("/bin/launchctl", arguments: ["unload","/System/Library/LaunchAgents/com.apple.rcd.plist"])
            
            println("Enabled custom event handling")
        }
        else if !enabled && customEventhandlingEnabled {
            // Disable KeyListeners
            mikeyListener?.stopListening()
            bluetoothListener?.stopListening()
            
            // Load rcd again
            NSTask.launchedTaskWithLaunchPath("/bin/launchctl", arguments: ["load", "/System/Library/LaunchAgents/com.apple.rcd.plist"])
            
            println("Disabled custom event handling")
        }
        
        customEventhandlingEnabled = enabled
    }

}

