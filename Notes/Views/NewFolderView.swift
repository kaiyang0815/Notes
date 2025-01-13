//
// NewFolderView.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI
import SwiftData

struct NewFolderView: View {
    @State private var folderName = "New Folder"
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Folder> {
        $0.parentFolder == nil
    }, sort: \Folder.name)
    var folders: [Folder]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("", text: $folderName)
                    .overlay(alignment: .trailing) {
                        if !folderName.isEmpty {
                            Button {
                                folderName = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.gray.opacity(0.45))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                
                Section {
                    NavigationLink {
                        Text("Make Into Smart Folder")
                    } label: {
                        HStack {
                            Image(systemName: "gearshape")
                                .foregroundStyle(.white)
                                .padding(4)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.accent)
                                }
                            VStack(alignment: .leading) {
                                Text(String(localized: "Make Into Smart Folder"))
                                Text(String(localized: "Organise using tags and other filters"))
                                    .font(.caption)
//                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle(String(localized: "New Folder"))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Text(String(localized: "Cancel"))
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        withAnimation {
                            let newFolder = Folder(name: folderName, order: folders.count)
                            modelContext.insert(newFolder)
                            dismiss()
                        }
                    } label: {
                        Text(String(localized: "Done"))
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    NewFolderView()
}
