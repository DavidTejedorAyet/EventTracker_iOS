//
//  CalendariosApp.swift
//  Calendarios
//
//  Created by David on 4/8/21.
//

import SwiftUI

@main
struct CalendariosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
