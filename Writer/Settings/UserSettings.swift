//
//  Settings.swift
//  Writer
//
//  Created by Michal Jach on 22/11/2020.
//

import Foundation
import Combine
import CoreData
import WidgetKit

class UserSettings: ObservableObject {
    @Published var heading: Bool {
        didSet {
            UserDefaults.standard.set(heading, forKey: "heading")
        }
    }
    
    @Published var firstLaunch: Bool {
        didSet {
            UserDefaults.standard.set(firstLaunch, forKey: "firstLaunch")
        }
    }
    
    @Published var selectedFolder: String {
        didSet {
            UserDefaults.standard.set(selectedFolder, forKey: "selectedFolder")
        }
    }
    
    @Published var fontFace: String {
        didSet {
            UserDefaults.standard.set(fontFace, forKey: "fontFace")
        }
    }
    
    @Published var fontSize: Double {
        didSet {
            UserDefaults.standard.set(fontSize, forKey: "fontSize")
        }
    }
    
    @Published var icon: String {
        didSet {
            UserDefaults.standard.set(icon, forKey: "icon")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["firstLaunch" : true])
        UserDefaults.standard.register(defaults: ["heading" : true])
        UserDefaults.standard.register(defaults: ["fontSize" : 17])
        self.heading = UserDefaults.standard.bool(forKey: "heading")
        self.firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
        self.selectedFolder = UserDefaults.standard.string(forKey: "selectedFolder") ?? "all"
        self.fontFace = UserDefaults.standard.string(forKey: "fontFace") ?? "default"
        self.fontSize = UserDefaults.standard.double(forKey: "fontSize")
        self.icon = UserDefaults.standard.string(forKey: "icon") ?? "default"
    }
    
    func createOnboardingData(viewContext: NSManagedObjectContext) {
        if let userDefaults = UserDefaults(suiteName: "group.com.mj.Writer") {
            userDefaults.set("Tap bookmark icon on selected note to see it here." as AnyObject, forKey: "widgetItem")
            userDefaults.synchronize()
            WidgetCenter.shared.reloadAllTimelines()
        }
        
        let item1 = Item(context: viewContext)
        item1.timestamp = Date()
        item1.isFavourited = false
        item1.content = "# Coming soon 🛠️\nWe deeply care about your experience thus we are constantly working on new features for *Writer*. Some of them are:\n- iOS 14 Widgets\n- Bookmarks\n- Sharing via short link\n- Themes and typography\n- Live collaboration with @mentions\nand many more...\n\n> You can always request a feature, you're welcomed !"
        
        let item2 = Item(context: viewContext)
        item2.timestamp = Date()
        item2.isFavourited = false
        item2.content = "# Markdown Editor\n*Writer* lets you focus on your text rather than poluting interface with buttons --- That's why it supports **Markdown**. You can use **bold**, *italic*, ~strikethrough~ in text.\n\n# This is example heading.\n> Highlighting important parts is also super easy.\n\nNeed a shopping list ?\n1. Bread\n2. Milk\n3. New iPhone\n\n***\n\nWith #hashtags you can easily make your note part of a #folder or many folders."
        
        let item3 = Item(context: viewContext)
        item3.timestamp = Date()
        item3.isFavourited = false
        item3.content = "# Secure Sync with CloudKit ☁️\n*Writer* stores all of **your** data in secure Apple Cloud. Your data stay safe and encrypted and it's not seen or manipulated by us in any way.\n\n1. Providing secure storage\n2. Automaticaly sync all your devices -- Mac, iPad, iPhone, Apple Watch.\n3. It's fast and convenient.\n\n***\n#sync #cloudkit "
        
        let item4 = Item(context: viewContext)
        item4.timestamp = Date()
        item4.isFavourited = false
        item4.content = "# Welcome to Writer 👋\nKeep your notes organized in beautiful and simple way !"
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
