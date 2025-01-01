//
// Item.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
