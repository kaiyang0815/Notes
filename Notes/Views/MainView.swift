//
// MainView.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI
import SwiftData

struct MainView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var showICloud: Bool = true
    @State private var selection: String?
    @State private var showNewFolderSheet: Bool = false
    
    @Query
    var folders: [Folder]
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            NavigationStack {
                List(selection: $selection) {
                    Section("iCloud", isExpanded: $showICloud) {
//                        ForEach(folders, id: \.id) { folder in
//                            NavigationLink {
//                                Text(folder.name)
//                            } label: {
//                                HStack {
//                                    Image(systemName: "folder")
//                                        .foregroundStyle(Color.accentColor)
//                                    Text(folder.name)
//                                }
//                                .badge(folder.notes.count)
//                                .padding(.trailing)
//                            }
//                            .buttonStyle(.plain)
//                        }
                        OutlineGroup(folders, children: \.subFolders) { folder in
                            Text(folder.name)
                        }
                    }
                    .headerProminence(.standard)
                }
                .navigationTitle("Folders")
                .toolbar {
                    #if os(iOS)
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            withAnimation {
                                showNewFolderSheet.toggle()
                            }
                        } label: {
                            Label("New Folder", systemImage: "folder.badge.plus")
                        }

                    }
                    ToolbarItem {
                        EditButton()
                    }
                    #endif
                }
                .listStyle(.sidebar)
                .sheet(isPresented: $showNewFolderSheet) {
                    NewFolderView()
                }
            }
        } content: {
            NotesListView()
        } detail: {
            NavigationStack {
                ScrollView {
                    
                }
            }
        }
    }
}

#Preview(traits: .previewData) {
    MainView()
}
