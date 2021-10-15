//
//  CustomPicker.swift
//  DemoCalendar
//
//  Created by 이용석 on 2021/10/10.
//

import SwiftUI

struct CustomPicker: View {
    @EnvironmentObject var taskClass: TaskClass
    @Binding var currrentDate: Date
    // 화살표 버턴 인덱스
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 30) {
            //요일 날짜
            let days: [String] = ["일","월","화","수","목","금","토"]
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(extractDate()[0])
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(extractDate()[1])
                        .font(.title).bold()
                }
                Spacer()
                Button(action: {
                    currentMonth -= 1
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                })
                Button(action: {
                    currentMonth += 1
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.title)
                })
            } // top title
            .padding(.horizontal)
            
            //요일 날짜
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text("\(day)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // 날짜
            //lazyVGrid View
            let colums = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: colums, spacing: 15) {
                ForEach(extractDate()) { value in
                    cardView(value: value)
                        .background (
                            Capsule()
                                .fill(Color.pink)
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currrentDate) ? 1: 0)
                        )
                        .onTapGesture {
                            currrentDate = value.date
                        }
                }
            }
            
            // Tasks View
            VStack(spacing: 10) {
                Text("Tasks")
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                if let taskMetaData = taskClass.tasks.first(where: { taskMetaData in
                    return isSameDay(date1: taskMetaData.taskDate, date2: currrentDate)
                }) {
                    ForEach(taskMetaData.task) { task in
                        VStack(alignment: .leading, spacing: 10) {
                            // for custom Time
                            Text(task.time.addingTimeInterval(TimeInterval(CGFloat.random(in: 0...5000))), style: .time)
                                .font(.title2).bold()
                            Text(task.title)
                                .font(.title3).bold()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Color.purple
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                    }
                }else {
                    Text("No Task Found")
                }
            }
            .padding()
        }
        .onChange(of: currentMonth) { newValue in
            //업데이트 month
            currrentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func cardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if let task = taskClass.tasks.first(where: { taskMetaData in
                    return isSameDay(date1: taskMetaData.taskDate , date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3).bold()
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currrentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currrentDate) ? .white : Color.pink)
                        .frame(width: 8, height: 8)
                }else {
                    Text("\(value.day)")
                        .font(.title3).bold()
                        .foregroundColor(isSameDay(date1: value.date, date2: currrentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    // checking date...
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else { return Date() }
        return currentMonth
    }
    
    func extractDate() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-kr")
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currrentDate)
        return date.components(separatedBy: " ")
    }
    
    func extractDate() ->[DateValue] {
        // 현재 달 얻기
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDate().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        //offset day index
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekDay - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}
// 현재 월.일. 얻음
extension Date {
    func getAllDate() -> [Date] {
        let calendar = Calendar.current
        // 시작일 얻음
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        //range.removeLast()
        //데이트 얻음
        return range.compactMap{ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}



struct CustomPicker_Previews: PreviewProvider {
    @StateObject static var taskClass: TaskClass = TaskClass()
    static var previews: some View {
        ContentView()
            .environmentObject(taskClass)
    }
}

