//
//  ContentView.swift
//  DemoCalendar
//
//  Created by 이용석 on 2021/10/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var taskClass = TaskClass()
    static var previews: some View {
        ContentView()
            .environmentObject(taskClass)
    }
}
