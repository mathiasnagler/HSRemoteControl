//
//  BooleanExtensions.swift
//  HSRemoteControl
//
//  Created by Mathias Nagler on 14.04.15.
//  Copyright (c) 2015 Mathias Nagler. All rights reserved.
//

import Foundation

extension Boolean: BooleanLiteralConvertible {
    public init(booleanLiteral value: Bool) {
        self = value ? 1 : 0
    }
}

extension Boolean: BooleanType {
    public var boolValue: Bool {
        return self != 0
    }
}
