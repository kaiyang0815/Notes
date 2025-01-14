//
// NotesListView.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftData
import SwiftUI

struct NotesListView: View {
    @State private var searchNoteString = ""

    let folder: Folder

    var todayNotes: [Note] {
        return folder.notes.filter {
            Calendar.current.isDateInToday($0.createdAt)
        }
    }

    var previous7DNotes: [Note] {
        let now = Date()
        let sevenDaysAgo = Calendar.current.date(
            byAdding: .day,
            value: -7,
            to: now
        )!
        return folder.notes.filter {
            $0.createdAt >= sevenDaysAgo
                && !Calendar.current.isDateInToday($0.createdAt)
        }
    }

    var previous30DNotes: [Note] {
        let now = Date()
        let thirtyDaysAgo = Calendar.current.date(
            byAdding: .day,
            value: -30,
            to: now
        )!
        let sevenDaysAgo = Calendar.current.date(
            byAdding: .day,
            value: -7,
            to: now
        )!
        return folder.notes.filter {
            $0.createdAt >= thirtyDaysAgo
                && $0.createdAt < sevenDaysAgo
        }
    }

    var previousYearNotes: [Note] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let previousYear = currentYear - 1
        return folder.notes.filter {
            let noteYear = Calendar.current.component(.year, from: $0.createdAt)
            return noteYear == previousYear
        }
    }

    var previousYear: String {
        let currentYear = Calendar.current.component(.year, from: Date())
        return String(currentYear - 1)
    }

    init(_ folder: Folder) {
        self.folder = folder
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Today") {
                    ForEach(todayNotes) { note in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(note.title)
                                .font(.headline)
                            Text(
                                note.createdAt.formatted(
                                    date: .numeric, time: .shortened)
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            HStack {
                                Image(systemName: "folder")
                                Text(folder.name)
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                if !previous7DNotes.isEmpty {
                    Section("Previous 7 Days") {
                        ForEach(previous7DNotes) { note in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(note.title)
                                    .font(.headline)
                                Text(
                                    note.createdAt.formatted(
                                        date: .numeric, time: .shortened)
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                HStack {
                                    Image(systemName: "folder")
                                    Text(folder.name)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                if !previous30DNotes.isEmpty {
                    Section("Previous 30 Days") {
                        ForEach(previous30DNotes) { note in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(note.title)
                                    .font(.headline)
                                Text(
                                    note.createdAt.formatted(
                                        date: .numeric, time: .shortened)
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                HStack {
                                    Image(systemName: "folder")
                                    Text(folder.name)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                if !previousYearNotes.isEmpty {
                    Section(previousYear) {
                        ForEach(previousYearNotes) { note in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(note.title)
                                    .font(.headline)
                                Text(
                                    note.createdAt.formatted(
                                        date: .numeric, time: .shortened)
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                HStack {
                                    Image(systemName: "folder")
                                    Text(folder.name)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle(folder.name)
            #if os(iOS)
                .listStyle(.insetGrouped)
            #endif
            .searchable(text: $searchNoteString)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button {

                        } label: {
                            Label(
                                "View as Gallery",
                                systemImage: "square.grid.2x2")
                        }
                        Divider()
                        Button {

                        } label: {
                            Label(
                                "Select Notes", systemImage: "checkmark.circle")
                        }
                        Button {

                        } label: {
                            Label("View Attachments", systemImage: "paperclip")
                        }
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                    }
                }
                ToolbarItem(placement: .status) {
                    Text("^[\(folder.notes.count) Note](inflect: true)")
                        .font(.caption)

                }
            }
        }
    }
}

#Preview(traits: .previewData) {
    NotesListView(SampleData.folder1)
}
