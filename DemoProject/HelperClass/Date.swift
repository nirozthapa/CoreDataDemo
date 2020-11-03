//
//  Date.swift
//  DemoProject
//
//  Created by Niroj Thapa on 11/4/20.
//

import Foundation
extension Date{
func dateFromString(dateStr: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
                                    .withInternetDateTime,
                                    .withDashSeparatorInDate,
                                    .withColonSeparatorInTime,
                                    .withColonSeparatorInTimeZone,
                                    .withFractionalSeconds,
                                    .withTimeZone
                                  ]
        return formatter.date(from: dateStr)
    }
}
