//
//  SwiftUICaneldarProjectApp.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 14/03/2022.
//

import SwiftUI

@main
struct SwiftUICaneldarProjectApp: App {
    
  @AppStorage("isDarkMode") var isDarkMode : String = "다크모드"
  @AppStorage("isCharStyle") var isCharStyle : String = ""
  @AppStorage("isSoundStyle") var isSoundStyle = 1327
    
  @StateObject var vm = CalendarViewModel()
  @StateObject var remindervm = ReminderViewModel()
    
  var body: some Scene {
    WindowGroup {
        HomeView()
            .environmentObject(vm)
            .environmentObject(remindervm)
    }
  }
}
