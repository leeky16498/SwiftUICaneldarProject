//
//  CreateReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import SwiftUI

struct CreateReminderView: View {
  @StateObject var remindervm = ReminderViewModel()
  @State private var isshowAlert : Bool = false
  @State private var textalert : String = ""
  @EnvironmentObject var vm : CalendarViewModel
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    VStack(spacing:20){
      Group{
        inputTextTitle
        inputTextSection
        Divider()
          .background(Color.caltheme.lightgray)
      }
      DatePicker("TaskDate", selection: $remindervm.taskDate, displayedComponents: .date)
        .font(.title3)
        .padding(.horizontal)
      Divider()
        .background(Color.caltheme.lightgray)
      CreateTaskTitle
      createdTask
      Group{
        Divider()
          .background(Color.caltheme.lightgray)
        colorSelectedTextSection
        colorCircleSection
       
        Spacer()
      }
      
      createButtonSection
        .padding(.bottom, 20)
    } //VSTACK
    .alert(isPresented: $isshowAlert, content: getAlert)
    //        }
  }
  
  func isPressedCreateReminer() {
    if textCondition(){
      presentationMode.wrappedValue.dismiss()
      remindervm.addItem(title: remindervm.createReminderText, selectedColor: remindervm.selectedColor, remindedtime: remindervm.toProgress)
      vm.addTasks(text: remindervm.taskTitle, taskDate: remindervm.taskDate)
    }
  }
  func textCondition() -> Bool {
    if remindervm.createReminderText.count < 2{
      textalert = "Please, insert at least 3 characters\n😅😅😅"
      isshowAlert = true
      return false
    } else {
      return true
    }
  }
  func getAlert() -> Alert{
    Alert(title: Text(textalert))
  }
}
struct CreateReminderView_Previews: PreviewProvider {
  static var previews: some View {
    CreateReminderView()
      .preferredColorScheme(.dark)
      .environmentObject(CalendarViewModel())
    
  }
}
extension CreateReminderView {
  private var inputTextTitle :some View{
    Text("Create a new remainder")
      .font(.title)
      .bold()
      .foregroundColor(Color.caltheme.secondaryText)
      .frame(maxWidth:.infinity, alignment: .leading)
      .padding(.horizontal)
  }
  private var inputTextSection : some View{
    HStack{
      TextField("Input your task...", text: $remindervm.createReminderText)
        .foregroundColor(
          remindervm.createReminderText.isEmpty ?
          Color.caltheme.secondaryText : remindervm.selectedColor)
        .disableAutocorrection(true)
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
      RoundedRectangle(cornerRadius: 15)
        .fill(Color.caltheme.background)
        .shadow(color: Color.caltheme.black.opacity(0.5), radius: 10, x: 0, y: 0)
    )
    .padding(.horizontal)
  }
  private var eventDetailTextSection: some View{
    Text("Event Detail")
      .frame(maxWidth:.infinity, alignment: .leading)
      .font(.title3)
      .foregroundColor(Color.caltheme.secondaryText)
      .padding(.horizontal)
  }
  private var CreateTaskTitle :some View{
    Text("Create a Task")
      .font(.title3)
      .bold()
      .foregroundColor(Color.caltheme.secondaryText)
      .frame(maxWidth:.infinity, alignment: .leading)
      .padding(.horizontal)
  }
  
  private var createdTask: some View{
    VStack {
      HStack{
        Text("Complete a previous task")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.caltheme.red)
          .cornerRadius(10)
        Text("Create new portfolio")
          .font(.headline)
          .padding()
          .frame(maxWidth: 130)
          .background(Color.caltheme.blue)
          .cornerRadius(10)
        Spacer()
      }
      HStack{
        Text("Complete a previous task")
          .font(.headline)
          .padding()
          .frame(maxWidth: 90)
          .background(Color.caltheme.yellow)
          .cornerRadius(10)
        Text("Create new portfolio")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.caltheme.green)
          .cornerRadius(10)
        Spacer()
      }
    }
    .padding(.horizontal)
    .lineLimit(1)
  }
  private var colorSelectedTextSection: some View{
    Text("Select Color")
      .font(.title3)
      .bold()
      .frame(maxWidth:.infinity, alignment: .leading)
      .foregroundColor(Color.caltheme.secondaryText)
//      .padding(.horizontal)
  }
  private var colorCircleSection: some View{
    HStack(spacing:5){
      ForEach(remindervm.circle, id:\.self){color in
        Circle()
          .frame(width: 40, height: 40)
          .foregroundColor(color)
          .background(
            Circle()
              .frame(width: 45, height: 45)
              .foregroundColor(color == remindervm.selectedColor ? Color.white : Color.clear)
              .shadow(color: color == remindervm.selectedColor ? Color.white : Color.clear, radius: 5, x: 0, y: 0))
          .onTapGesture {
            withAnimation(.easeIn){
              remindervm.selectedColor = color
            }
          }
      }
      .frame(maxWidth:.infinity)
      .padding()
    }
  }
  
  private var timeTextSection: some View{
    HStack(spacing : 0) {
      Text(remindervm.toProgress.roundCGFloat())
        .frame(width:50)
      Text("Minutes")
        .frame(width:130)
    }
    .font(.largeTitle.bold())
    .foregroundColor(Color.caltheme.secondaryText)
    .padding()
    .scaleEffect(1.5)
  }
  private var createButtonSection: some View{
    Button(action: {
      isPressedCreateReminer()
    }, label: {
      Text("Create Reminder")
    })
    .font(.title)
    .foregroundColor(Color.caltheme.secondaryText)
    .frame(maxWidth: .infinity)
    .frame(height:50)
    .background(remindervm.selectedColor)
    .cornerRadius(10)
    .padding()
  }
}
