//
//  AddTaskView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 20/03/2022.
//

import SwiftUI

struct AddTaskView: View {
    
    @State var taskDate : Date = Date()
    @State var taskTitle : String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm : CalendarViewModel
    
    
    var body: some View {
        VStack {
            TextField("테스크 이름", text: $taskTitle)
                .foregroundColor(.black)
                .background(.white)
            DatePicker("TaskDate", selection: $taskDate, displayedComponents: .date)
            Button {
                presentationMode.wrappedValue.dismiss()
                vm.addTasks(text: taskTitle, taskDate: taskDate)
            } label: {
                Text("Save")
            }

        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
