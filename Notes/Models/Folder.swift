//
// Folder.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftData
import SwiftUI

@Model
final class Folder {
    var id: UUID
    var name: String
    var order: Int
    var parentFolder: Folder?
    var subFolders: [Folder]?
    var notes: [Note]

    init(
        id: UUID = UUID(),
        name: String,
        order: Int,
        parentFolder: Folder? = nil,
        subFolders: [Folder]? = nil,
        notes: [Note] = []
    ) {
        self.id = id
        self.name = name
        self.order = order
        self.parentFolder = parentFolder
        self.subFolders = subFolders
        self.notes = notes
    }
}

@Model
final class Note {
    var id: UUID
    var title: String
    var content: String
    @Relationship(deleteRule: .cascade, inverse: \Folder.notes)
    var folder: Folder?

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        folder: Folder? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.folder = folder
    }
}
