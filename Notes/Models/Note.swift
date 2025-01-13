//
// Note.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import Foundation
import SwiftData

@Model
final class Note {
    var id: UUID
    var title: String
    var content: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Folder.notes)
    var folder: Folder?

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        createdAt: Date = .now,
        folder: Folder? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.folder = folder
    }
}
