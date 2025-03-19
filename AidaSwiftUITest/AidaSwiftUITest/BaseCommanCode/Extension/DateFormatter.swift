//
//  DateFormatter.swift
//  UmbrellaApp
//
//  Created by Maksym Musiienko on 12/11/17.
//  Copyright © 2017 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

enum DateFormat: String {

    case hourMinute = "HH:mm"
    case history = "yyyy-MM-dd"
    case month = "MMM"
    case fullMonth = "MMMM"
    case sessionDate = "dd.MM.yyyy"
    case sessionDuration = "HH'h' mm'm'"
    case smsDate = "ddMMyyyyHHmm"
    case apiDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" ///2024-08-30T14:23:45.678+0530
    case consentAPIDateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case shortDateTime = "dd/MM/yyyy HH:mm"
    
    ///This is the default date format for the app.
    static var `default`: DateFormat {
        return apiDateFormat
    }
}

extension DateFormatter {

    convenience init(format: DateFormat, timeZone: TimeZone? = TimeZone(secondsFromGMT: 0), locale: Locale) {
        self.init()
        self.dateFormat = format.rawValue
        self.timeZone = timeZone
        self.locale = locale
    }
}
