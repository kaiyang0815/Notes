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

    @Query
    var notes: [Note]

    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    Text(note.title)
                }
            }
            .navigationTitle("Notes")
            #if os (iOS)
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
                    Text("30 Notes")
                        .font(.caption)

                }
            }
        }
    }
}

#Preview(traits: .previewData) {
    NotesListView()
}
