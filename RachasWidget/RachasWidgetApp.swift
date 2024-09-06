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
            CalendarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
