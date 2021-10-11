//
//  DateValue.swift
//  DemoCalendar
//
//  Created by 이용석 on 2021/10/10.
//

import SwiftUI

struct DateValue: Identifiable {
    var id: String = UUID().uuidString
    var day: Int
    var date: Date
}

