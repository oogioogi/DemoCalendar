//
//  DemoCalendarApp.swift
//  DemoCalendar
//
//  Created by 이용석 on 2021/10/10.
//

import SwiftUI

@main
struct DemoCalendarApp: App {
    @StateObject var taskClass = TaskClass()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskClass)
        }
    }
}
