//
// MainView.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftData
import SwiftUI

struct MainView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var showICloud: Bool = true
    @State private var selection: String?
    @State private var showNewFolderSheet: Bool = false
    @State private var searchText: String = ""
    @State private var selectedFolder: Folder?
    @State private var selectedNote: Note?
    @Query(
        filter: #Predicate<Folder> {
            !$0.name.isEmpty
        }, sort: \Folder.order)
    var folders: [Folder]

    func totalNotes(_ folder: Folder) -> Int {
        var count = folder.notes.count
        if let subFolders = folder.subFolders {
            subFolders.forEach { subFolder in
                count += totalNotes(subFolder)
            }
        }
        return count
    }

    @ViewBuilder
    func FolderRow(_ folder: Folder) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "folder")
                .foregroundStyle(
                    Color.accentColor)
            Text(folder.name)
        }
        .badge(folder.notes.count)
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            NavigationStack {
                List(selection: $selectedFolder) {
                    NavigationLink {
                        Text("Quick Note")
                    } label: {
                        HStack {
                            Image(systemName: "note")
                                .foregroundStyle(
                                    Color.accentColor)
                            Text("Quick Note")
                        }
                        .padding(.trailing)
                    }
                    .buttonStyle(.plain)

                    Section(isExpanded: $showICloud) {
                        ForEach(folders, id: \.id) { folder in
                            if let sub = folder.subFolders {
                                if sub.isEmpty {
                                    NavigationLink(value: folder) {
                                        FolderRow(folder)
                                    }
                                    .buttonStyle(.plain)
                                } else {
                                    DisclosureGroup {
                                        ForEach(sub) { folder in
                                            NavigationLink(value: folder) {
                                                FolderRow(folder)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    } label: {
                                        NavigationLink(value: folder) {
                                            FolderRow(folder)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("iCloud")
                    }
                }
                .navigationTitle("Folders")
                .toolbar {
                    #if os(iOS)
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button {
                                withAnimation {
                                    showNewFolderSheet.toggle()
                                }
                            } label: {
                                Label(
                                    "New folder",
                                    systemImage: "folder.badge.plus")
                            }
                            Spacer()
                            Button {

                            } label: {
                                Label(
                                    "New note",
                                    systemImage: "square.and.pencil")
                            }
                        }
                        ToolbarItem {
                            EditButton()
                        }
                    #endif
                }
                .listStyle(.sidebar)
                .searchable(text: $searchText)
                .sheet(isPresented: $showNewFolderSheet) {
                    NewFolderView()
                }
            }
        } content: {
            if let selectedFolder {
                NotesListView(selectedFolder: selectedFolder, selectedNote: $selectedNote)
            }
        } detail: {
            if let selectedNote {
                NavigationStack {
                    ScrollView {
                        Text(selectedNote.title)
                    }
                }
            }
        }
    }
}

#Preview(traits: .previewData) {
    MainView()
}
