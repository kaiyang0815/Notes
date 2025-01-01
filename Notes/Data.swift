//
// Data.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import Foundation
import SwiftUI
import SwiftData

/// A modifier that creates the a model container for the preview data.
struct PreviewData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Folder.self, Folder.self,
            configurations: config
        )

        for folder in SampleData.folders {
            container.mainContext.insert(folder)
        }

        for note in SampleData.notes {
            container.mainContext.insert(note)
        }

        return container
    }

    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var previewData: Self = .modifier(PreviewData())
}

struct SampleData {}

extension SampleData {
    @MainActor static let folders = [
        Folder(name: "笔记"),
        Folder(name: "归档"),
        Folder(name: "总结"),
    ]

    @MainActor static let notes = [
        Note(title: "2024年年终总结", content: "", folder: folders[2]),
        Note(title: "常用命令行", content: "", folder: folders[0])
    ]
}
