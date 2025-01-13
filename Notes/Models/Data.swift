//
// Data.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import Foundation
import SwiftData
import SwiftUI

/// A modifier that creates the a model container for the preview data.
struct PreviewData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Folder.self,
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
    @MainActor static let folder1 = Folder(name: "Notes", order: 0, subFolders: [])
    @MainActor static let folder2 = Folder(name: "Notes", order: 1, subFolders: [])
    @MainActor static let folder3 = Folder(name: "Notes", order: 2, subFolders: [])

    @MainActor static let folders = [folder1, folder2, folder3]

    @MainActor static let notes = [
        Note(title: "Note 1", content: "", folder: folders[2]),
        Note(title: "Note 2", content: "", folder: folders[0]),
    ]
}
