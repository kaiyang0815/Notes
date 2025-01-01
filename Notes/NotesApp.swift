//
// NotesApp.swift
// Notes
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Folder.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @State private var presentation = Presentation()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(presentation)
                .frame(minWidth: design.minWindowWidth, minHeight: design.minWindowHeight)
        }
        .modelContainer(sharedModelContainer)
    }
}

fileprivate typealias design = Design.App
