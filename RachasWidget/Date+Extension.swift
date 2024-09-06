//
//  Date+Extension.swift
//  RachasWidget
//
//  Created by Juan Hernandez Pazos on 05/09/24.
//

import Foundation

extension Date {
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.end
    }
    
    var endOfDay: Date {
        Calendar.current.dateInterval(of: .day, for: self)!.end
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var startOfNextMonth: Date {
        let dayInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self)!
        return dayInNextMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
            // endOfMonth returns the 1st of next month at midnight.
            // An adjustment of -1 is necessary to get last day of current month
        let endDateAdjustment = Calendar.current.date(byAdding: .day, value: -1, to: self.endOfMonth)!
        return Calendar.current.component(.day, from: endDateAdjustment)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var monthFullName: String {
        self.formatted(.dateTime.month(.wide))
    }
    
    // para colocar los días generados en el día inicial del mes
    var startOfCalendarWithPrefixDays: Date {
            // que día de la semana es el primero del mes
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
            // ajustar los días porque no son index 0
        let numberOfPrefixDays = startOfMonthWeekday - 1
            // hacer el cálculo
        let startDate = Calendar.current.date(byAdding: .day, value: -numberOfPrefixDays, to: startOfMonth)!
        return startDate
    }
}
