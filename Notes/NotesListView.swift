//
// NotesListView.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI

struct NotesListView: View {
    @State private var searchNoteString = ""
    
    
    var body: some View {
        NavigationStack {
            List {
            }
            .navigationTitle("Notes")
            .searchable(text: $searchNoteString)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button {
                            
                        } label: {
                            Label("View as Gallery", systemImage: "square.grid.2x2")
                        }
                        Divider()
                        Button {
                            
                        } label: {
                            Label("Select Notes", systemImage: "checkmark.circle")
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

#Preview {
    NotesListView()
}
