//
//  HidAuxKeyPoster.h
//  HSRemoteControl
//
//  Created by Mathias Nagler on 10.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HIDAuxKeyPoster: NSObject

+ (void)HIDPostAuxKey:(UInt8)auxKeyCode;

@end
