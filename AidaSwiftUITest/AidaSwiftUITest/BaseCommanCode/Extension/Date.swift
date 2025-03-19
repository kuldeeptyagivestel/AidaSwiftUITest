//
//  Date.swift
//  UmbrellaApp
//
//  Created by Maksym Musiienko on 12/14/17.
//  Copyright © 2017 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

extension Date {
    
    func isSameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        return
            calendar.component(.year, from: self) == calendar.component(.year, from: date) &&
                calendar.component(.month, from: self) == calendar.component(.month, from: date)
    }
    
    func isSameDay(as date: Date) -> Bool {
           let calendar = Calendar.current
           return
               calendar.component(.year, from: self) == calendar.component(.year, from: date) &&
                   calendar.component(.month, from: self) == calendar.component(.month, from: date) && calendar.component(.day, from: self) == calendar.component(.day, from: date)
       }
    
    /*var startOfMonth: Date {
     var components = Calendar.current.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: self)
     components.day = 1
     components.hour = 0
     components.minute = 0
     components.second = 0
     components.nanosecond = 0
     return Calendar.current.date(from: components)!
     }*/
    
    func component(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
    func components(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func readableFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
    
    /// Returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func dayNumberOfWeek() -> Int? {
           return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
	///Age Calculator
    func ageCalculator() -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
	static func from(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }

    static func from(_ string: String, format: String = "yyyyMMddHHmmss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
}

extension Date {
    func toString(format: String = "MMM dd, EEEE") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func formatted(as format: DateFormat) -> String {
        DateFormatter(format: format, timeZone: .current, locale: .current).string(from: self)
    }
    
    func toString(format: DateFormat = .default) -> String {
        // Convert Date to String using AidaDateFormatter
        return AidaDateFormatter(format: format).string(from: self)
    }
}

extension Date {
    /**
     Returns a string representing the last update from a given date.

     - Parameters:

        - date: The date to be used for getting the last update time.
     
     - Returns: A string representing the last update from the given date.
    */
    public func lastUpdateString() -> String {
        // Use a single instance of DateFormatter and Calendar
        let dateFormatter = AidaDateFormatter()
        var calendar = Calendar.current
        calendar.locale = dateFormatter.locale

        if calendar.isDateInToday(self) {
            // Use localized string for "No Update Today" and include the time
            dateFormatter.dateFormat = " HH:mm"
            return .localized(.today) + dateFormatter.string(from: self)
        } else {
            // Use "dd MMM" format for other dates
            dateFormatter.dateFormat = "dd MMM HH:mm"
            return dateFormatter.string(from: self)
        }
    }
    
    /**
    Returns a string representing the last update from a given timestamp.

    - Parameters:
        
     - timestamp: The timestamp to be used for getting the last update time.
    
    - Returns: A string representing the last update from the given timestamp.
    */
    public static func lastUpdateString(from timestamp: TimeInterval) -> String {
        // Convert the identifier to a Date object
        return Date(timeIntervalSince1970: timestamp).lastUpdateString()
    }
}
