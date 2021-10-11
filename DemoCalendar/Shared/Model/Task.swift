//
//  Task.swift
//  DemoCalendar
//
//  Created by 이용석 on 2021/10/11.
//

import SwiftUI
// task model and sample task
// array task
struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var time: Date = Date()
}
// total task meta View
struct TaskMetaData: Identifiable {
    var id: String = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}
// sample task testing
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

class TaskClass: ObservableObject {
    // sample task
    @Published var tasks: [TaskMetaData] = [
        TaskMetaData(task: [
            Task(title: "task title 0.1"),
            Task(title: "task title 0.2"),
            Task(title: "task title 0.3"),
        ], taskDate: getSampleDate(offset: 1)),
        TaskMetaData(task: [
            Task(title: "task title 1.1"),
            Task(title: "task title 1.2"),
            Task(title: "task title 1.3"),
        ], taskDate: getSampleDate(offset: 2)),
        TaskMetaData(task: [
            Task(title: "task title 2.1"),
            Task(title: "task title 2.2"),
            Task(title: "task title 2.3"),
        ], taskDate: getSampleDate(offset: 3)),
    ]
}

