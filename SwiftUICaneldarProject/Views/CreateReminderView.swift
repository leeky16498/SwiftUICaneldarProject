//
//  CreateReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import SwiftUI
struct CreateReminderView: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var vm : CalendarViewModel
  @StateObject var remindervm = ReminderViewModel()
  @State private var textalert : String = ""
  @State private var oldTaskTitle : String = ""
    @State private var oldTaskDate : Date = Date()
    @State private var oldContents : String = ""
    @State private var oldColor : Color = Color.caltheme.red
  @State private var isEditMode : Bool = false
  var selectedTask : TaskModel?
  
  init(task : TaskModel?) {
    if let task = task {
      self.selectedTask = task
      _oldTaskTitle = State(initialValue: selectedTask?.title ?? "")
      _oldColor = State(initialValue: selectedTask?.selectedColor ?? Color.caltheme.red)
      _oldContents = State(initialValue: selectedTask?.content ?? "")
      _isEditMode = State(initialValue: true)
    }
  }
  
  var body: some View {
    VStack(spacing:20){
      inputTextTitleSection
        .padding(.top,60)
      inputTextSection
      inputTextEditor
      Divider()
        .background(Color.caltheme.lightgray)
      inputDateSection
      TextTitle(textTitle: "Select Color")
      circleColorSection
        .padding(.vertical,15)
      createButtonSection
        .padding(.bottom, 20)
      Spacer()
      
    }
    .alert(isPresented: $remindervm.isshowAlert, content: remindervm.getAlert)
  }
    
  func saveEditedTask(task : TaskModel) {
    if let index = vm.tasks.firstIndex(where: {$0.id == task.id}) {
        vm.tasks[index] = task.editedItem(title: oldTaskTitle, content: oldContents, selectedColor: oldColor, taskDate: oldTaskDate)
      presentationMode.wrappedValue.dismiss()
      isEditMode = false
    }
  }
  
  func isPressedCreateReminer() {
      vm.addTask(title: oldTaskTitle, content: oldContents, selectedColor: oldColor, taskDate: oldTaskDate, remindedTime: remindervm.hours)
    presentationMode.wrappedValue.dismiss()
    isEditMode = false
  }
}

//struct CreateReminderView_Previews: PreviewProvider {
//  static var previews: some View {
//    CreateReminderView()
//      .preferredColorScheme(.dark)
//      .environmentObject(CalendarViewModel())
//  }
//}

extension CreateReminderView {
  private var inputTextTitleSection : some View{
    Text("New Reminder ✅")
      .font(.title)
      .bold()
      .foregroundColor(Color.black)
      .frame(maxWidth:.infinity, alignment: .leading)
      .padding(.horizontal)
  }
    
  @ViewBuilder
  private var inputTextSection : some View {
    HStack{
      TextField("Input your title...", text: $oldTaskTitle)
        .foregroundColor(
          remindervm.createReminderText.isEmpty ?
          Color.caltheme.secondaryText : remindervm.selectedColor)
        .disableAutocorrection(true)
        .frame(height:40)
        .padding(.horizontal,7)
        .overlay(
          Image(systemName: "xmark.circle.fill")
            .padding()
            .offset(x: 10)
            .foregroundColor(remindervm.selectedColor)
            .opacity(remindervm.createReminderText.isEmpty ? 0.0 : 1.0)
            .onTapGesture {
              UIApplication.shared.closeKeyboard()
              remindervm.createReminderText = ""
            }
          ,alignment:  .trailing
        )
    }
    .font(.title3)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.caltheme.background)
        .shadow(color: Color.caltheme.black.opacity(0.3), radius: 5, x: 0, y: 0)
    )
    .padding(.horizontal)
    
    Divider()
      .background(Color.caltheme.lightgray)
  }
    
  @ViewBuilder
  private var inputTextEditor: some View{
    VStack {
        ZStack(alignment : .topLeading){
        TextEditor(text: $oldContents)
          .font(.title3)
          .foregroundColor(remindervm.textEditorTodo.isEmpty ? Color.caltheme.secondaryText : oldColor)
          .frame(width: UIScreen.main.bounds.width * 0.9)
          .frame(height:200)
          .lineSpacing(8)
          .cornerRadius(15)
          .padding(.leading)
          .padding(.trailing)
          .background(
            RoundedRectangle(cornerRadius: 15)
              .fill(Color.caltheme.background)
              .frame(width: UIScreen.main.bounds.width * 0.92)
              .shadow(color: Color.caltheme.black.opacity(0.3), radius: 5, x: 0, y: 0)
          )
            if remindervm.textEditorTodo.isEmpty && oldContents.count == 0{
          Text("Input your task...")
            .font(.title2)
            .foregroundColor(.gray.opacity(0.5))
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(.leading, 22)
            .padding(.vertical)
        }
      }
    }
  }
  @ViewBuilder
  private var inputDateSection: some View{
    DatePicker("Task Date", selection: $oldTaskDate)
      .font(.title3.bold())
      .foregroundColor(Color.caltheme.secondaryText)
      .padding(.horizontal)
    Divider()
      .background(Color.caltheme.lightgray)
  }
  
  private var circleColorSection: some View{
    HStack(spacing:5){
      ForEach(remindervm.circle, id:\.self){color in
        Circle()
          .frame(width: 40, height: 40)
          .foregroundColor(color)
          .background(
            Circle()
              .frame(width: 45, height: 45)
              .foregroundColor(color == oldColor ? Color.white : Color.clear)
              .shadow(color: color == oldColor ? Color.white : Color.clear, radius: 5, x: 0, y: 0))
          .onTapGesture {
            withAnimation(.easeIn){
              oldColor = color
            }
          }
      }
      .frame(maxWidth:.infinity)
      .padding(.horizontal)
    }
  }
  
  private var createButtonSection: some View{
    Button(action: {
      if let task = selectedTask {
        saveEditedTask(task: task)
      } else {
        isPressedCreateReminer()
      }
    }, label: {
      Text(isEditMode ? "Save Edited Reminder" : "Create Reminder")
    })
    .font(.title)
    .foregroundColor(Color.white)
    .frame(maxWidth: .infinity)
    .frame(height:50)
    .background(oldColor)
    .cornerRadius(10)
    .padding(.horizontal)
    .shadow(color: Color.caltheme.black.opacity(0.3), radius: 5, x: 0, y: 0)
  }
}
