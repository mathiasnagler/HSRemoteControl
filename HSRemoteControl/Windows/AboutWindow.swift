//
//  AboutWindow.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 12.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import AppKit

class AboutWindow: NSWindow {
    
    // MARK: - Properties
    
    @IBOutlet var textView: NSTextView!
    
    // MARK: - Nib Handling
    
    override func awakeFromNib() {
        if let aboutPath = NSBundle.mainBundle().pathForResource("About", ofType: "rtfd") {
            textView.readRTFDFromFile(aboutPath)
        }
    }
    
}
