//
//  MediaKey.h
//  HeadsetRemoteListener
//
//  Created by Tobias Becker on 09.04.15.
//  Copyright (c) 2015 Tobias Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaKey : NSObject
+ (void)send:(int)key;
@end
