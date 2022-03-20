//
//  SwiftUICaneldarProjectApp.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 14/03/2022.
//

import SwiftUI

@main
struct SwiftUICaneldarProjectApp: App {
    
    @StateObject var vm = CalendarViewModel()
    
    var body: some Scene {
        WindowGroup {
//            CreateReminderView()
//            ReminderListView()
            ContentView()
                .environmentObject(vm)
        }
    }
}
