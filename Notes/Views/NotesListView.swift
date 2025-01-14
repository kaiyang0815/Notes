//
// NotesListView.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftData
import SwiftUI

struct NotesListView: View {
    
    @Environment(\.modelContext) private var modelContext

    @State private var searchNoteString = ""

    let selectedFolder: Folder

    @Binding var selectedNote: Note?

    var todayNotes: [Note] {
        return selectedFolder.notes.filter {
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
        return selectedFolder.notes.filter {
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
        return selectedFolder.notes.filter {
            $0.createdAt >= thirtyDaysAgo
                && $0.createdAt < sevenDaysAgo
        }
    }

    var previousYearNotes: [Note] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let previousYear = currentYear - 1
        return selectedFolder.notes.filter {
            let noteYear = Calendar.current.component(.year, from: $0.createdAt)
            return noteYear == previousYear
        }
    }

    var previousYear: String {
        let currentYear = Calendar.current.component(.year, from: Date())
        return String(currentYear - 1)
    }

    var body: some View {
        NavigationStack {
            List(selection: $selectedNote) {
                Section {
                    ForEach(todayNotes) { note in
                        NavigationLink(value: note) {
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
                                    Text(selectedFolder.name)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    HStack {
                        Text("Today")
                            .font(.headline)
                            .textCase(nil)
                        Spacer()
                    }
                    .foregroundStyle(.primary)
                }
                if !previous7DNotes.isEmpty {
                    Section {
                        ForEach(previous7DNotes) { note in
                            NavigationLink(value: note) {
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
                                        Text(selectedFolder.name)
                                    }
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        }
                    } header: {
                        HStack {
                            Text("Previous 7 Days")
                                .font(.headline)
                                .textCase(nil)
                            Spacer()
                        }
                        .foregroundStyle(.primary)
                    }
                }
                if !previous30DNotes.isEmpty {
                    Section {
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
                                    Text(selectedFolder.name)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    } header: {
                        HStack {
                            Text("Previous 30 Days")
                                .font(.headline)
                                .textCase(nil)
                            Spacer()
                        }
                        .foregroundStyle(.primary)
                    }
                }
                if !previousYearNotes.isEmpty {
                    Section {
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
                                    Text(selectedFolder.name)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    } header: {
                        HStack {
                            Text(previousYear)
                                .font(.headline)
                                .textCase(nil)
                            Spacer()
                        }
                        .foregroundStyle(.primary)
                    }
                }
            }
            .listSectionSpacing(8)
            .navigationTitle(selectedFolder.name)
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
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Text("^[\(selectedFolder.notes.count) Note](inflect: true)")
                        .font(.caption)
                    Spacer()
                    Button {
                        let newNote = Note(title: "Default", content: "")
                        modelContext.insert(newNote)
                        selectedFolder.notes.append(newNote)
                        selectedNote = newNote
                    } label: {
                        Label(
                            "New note",
                            systemImage: "square.and.pencil")
                    }
                }
            }
        }
    }
}

#Preview(traits: .previewData) {
    MainView()
}
