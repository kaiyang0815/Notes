//
//  DateHelper.swift
//  Notes
//
//  Created by kaiyang0815 on 2025/1/14.
//
//

import SwiftUI

class DateHelper {
    static let shared = DateHelper()  // The single instance
    private init() {}  // Private initializer to prevent creating new instances

    func createDate(_ year: Int, _ month: Int, _ day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day

        return Calendar.current.date(from: components) ?? Date()
    }
}
