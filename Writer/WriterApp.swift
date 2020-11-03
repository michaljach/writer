//
//  WriterApp.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI

@main
struct WriterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
