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
    let settings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settings)
        }
    }
}

extension App {
    static var appVersion: String? {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        return "\(version) build \(build)"
    }
}
