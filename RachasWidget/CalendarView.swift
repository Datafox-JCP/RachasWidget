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
        predicate: NSPredicate(
            format: "(date >= %@) AND (date <= %@)",
            Date().startOfCalendarWithPrefixDays as CVarArg,
            Date().endOfMonth as CVarArg
        ))
    private var days: FetchedResults<Day>
    
//    let daysOfWeek = ["D", "L", "M", "M", "J", "V", "S"]
    let daysOfWeek = Calendar.current.shortWeekdaySymbols

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
                        if day.date!.monthInt != Date().monthInt {
                            Text("")
                        } else {
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
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(Date().formatted(.dateTime.month(.wide)))
            .onAppear {
                if days.isEmpty {
                    createMonthDays(for: .now.startOfPreviousMonth)
                    createMonthDays(for: .now)
                } else if days.count < 10 { // sólo para los días prefijo
                    createMonthDays(for: .now)
                }
            }
        }
    }
    
    // Función para crear los días
    func createMonthDays(for date: Date) {
        for dayOffset in 0..<date.numberOfDaysInMonth {
            let newDay = Day(context: viewContext)
            newDay.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth)
            newDay.didExercise = false
        }
        
        do {
            try viewContext.save()
            print("✅ Creados días del mes \(date.monthFullName)")
        } catch {
            print("😈 Error al guardar \(error.localizedDescription)")
        }
    }
}

#Preview {
    CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
