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
    @StateObject var tabbarController: TabbarViewController = TabbarViewController()

    var body: some Scene {
        WindowGroup {
            MainView(tabbarController: tabbarController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
