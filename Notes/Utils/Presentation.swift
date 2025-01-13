//
// Presentation.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import Foundation
import Observation

enum CollectionLayoutStyle: Int, CaseIterable, Identifiable {
    case list
    case grid
    
    var displayImageName: String {
        switch self {
        case .grid: return "square.grid.2x2"
        case .list: return "list.bullet"
        }
    }
    var displayName: String {
        switch self {
        case .grid: return "as Grid"
        case .list: return "as List"
        }
    }
    var id: Int { rawValue }
    var toolTipName: String {
        switch self {
        case .grid: return "View as Grid"
        case .list: return "View as List"
        }
    }
}

@Observable
final class Presentation {
    var layoutStyle: CollectionLayoutStyle
    
    init(layoutStyle: CollectionLayoutStyle = .grid) {
        self.layoutStyle = layoutStyle
    }
}
