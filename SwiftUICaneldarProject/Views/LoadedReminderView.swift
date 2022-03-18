//
//  LoadedReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/17.
//

import SwiftUI
import CoreData
struct LoadedReminderView: View {
    @StateObject var vm = ReminderViewModel()
    var body: some View {
        List{
            ForEach(vm.savedEntity){ entity in
                Text(entity.content ?? "no")
                Text(entity.selectedColor ?? "no")
            }
        }
    }
}

struct LoadedReminderView_Previews: PreviewProvider {
    static var previews: some View {
        LoadedReminderView()
    }
}
