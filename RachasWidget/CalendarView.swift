//
//  CalendarView.swift
//  RachasWidget
//
//  Created by Juan Hernandez Pazos on 05/09/24.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
        animation: .default)
    private var days: FetchedResults<Day>
    
//    let daysOfWeek = ["D", "L", "M", "M", "J", "V", "S"]
    let daysOfWeek = Calendar.current.veryShortWeekdaySymbols

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ForEach(daysOfWeek, id: \.self) { dayOfWeek in
                        Text(dayOfWeek)
                            .fontWeight(.black)
                            .foregroundStyle(.indigo)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()),count: 7)) {
                    ForEach(days) { day in
                        Text(day.date!.formatted(.dateTime.day()))
                            .bold()
                            .foregroundStyle(day.didExercise ? .indigo : .secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(.indigo.opacity(day.didExercise ? 0.4 : 0))
                            )
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(Date().formatted(.dateTime.month(.wide)))
        }
    }
}

#Preview {
    CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
