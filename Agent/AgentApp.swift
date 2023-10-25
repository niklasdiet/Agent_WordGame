//
//  AgentApp.swift
//  Agent
//
//  Created by Niklas Diet on 29.09.23.
//

import SwiftUI

@main
struct AgentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            StartScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
