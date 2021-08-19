//
//  CalendariosApp.swift
//  Calendarios
//
//  Created by David on 4/8/21.
//

import SwiftUI

@main
struct CalendariosApp: App {
    @StateObject var tabbarController: TabbarController = TabbarController()

    var body: some Scene {
        WindowGroup {
            MainView(tabbarController: tabbarController)
        }
    }
    
}
