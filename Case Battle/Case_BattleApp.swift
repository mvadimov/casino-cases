//
//  Case_BattleApp.swift
//  Case Battle
//
//  Created by Mark Vadimov on 23.04.24.
//

import SwiftUI
import SwiftData

@main
struct Case_BattleApp: App {
    @StateObject var viewModel = InfoList()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Group.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            StartView().environmentObject(InfoList())
        }
    }
}
