//
//  main.swift
//  HSRemoteControlLaunchHelper
//
//  Created by Mathias Nagler on 14.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Cocoa

// Check if main app is already running; if yes, do nothing and terminate
var alreadyRunning = false
let running = NSWorkspace.sharedWorkspace().runningApplications
for application in running {
    if application.bundleIdentifier == "de.mathiasnagler.HSRemoteControl" {
        alreadyRunning = true
    }
}

if !alreadyRunning {
    let path = NSBundle.mainBundle().bundlePath
    var pathComponents = path.pathComponents
    pathComponents.removeLast()
    pathComponents.removeLast()
    pathComponents.removeLast()
    pathComponents.append("MacOS")
    pathComponents.append("HSRemoteControl")
    let newPath = NSString.pathWithComponents(pathComponents)
    NSWorkspace.sharedWorkspace().launchApplication(newPath)
    println("HSRemoteControl has been started")
}
else {
    println("HSRemoteControl is already running")
}