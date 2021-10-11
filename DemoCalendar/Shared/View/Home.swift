//
//  Home.swift
//  DemoCalendar
//
//  Created by 이용석 on 2021/10/10.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var taskClass: TaskClass
    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CustomPicker(currrentDate: $currentDate)
            }
            .padding(.vertical)
        }
        .overlay (
            HStack {
                Button(action: {
                    taskClass.tasks.append(TaskMetaData(task: [Task(title: "Annul")], taskDate: currentDate))
                }, label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                })
                
                Button(action: {
                    let removeIndex = taskClass.tasks.firstIndex { taskMetaData in
                        //debugPrint(taskMetaData.taskDate)
                        return taskMetaData.taskDate == currentDate
                    }
                    
                    //debugPrint(currentDate)
                    
                    if removeIndex != nil {
                        //debugPrint(removeIndex?.description)
                        taskClass.tasks.remove(at: removeIndex!)
                    }
                    
                }, label: {
                    Text("Task Remainder")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                })
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .foregroundColor(.white),
            alignment: .bottom
        )
        
        // safe area inset
        //.safeAreaInset(){}
    }
}

struct Home_Previews: PreviewProvider {
    @StateObject static var taskClass: TaskClass = TaskClass()
    static var previews: some View {
        ContentView()
            .environmentObject(taskClass)
    }
}
