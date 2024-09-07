//
//  RachasWidgetApp.swift
//  RachasWidget
//
//  Created by Juan Hernandez Pazos on 05/09/24.
//

import SwiftUI

@main
struct RachasWidgetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                CalendarView()
                    .tabItem { Label("Calendario", systemImage: "calendar") }
                
                StreakView()
                    .tabItem { Label("Racha", systemImage: "swift") }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
