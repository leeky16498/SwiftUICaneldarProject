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
  
  var body: some View {
    VStack(spacing:20){
      Group{
        inputTextTitleSection
          .padding(.top,60)
        inputTextSection
        inputDateSection
        TextTitle(textTitle: "TaskDuration")
        inputTimeSection
        TextTitle(textTitle: "Create a Task")
      }
      createdTaskTitleSection
      TextTitle(textTitle: "Select Color")
      circleColorSection
      Spacer()
      createButtonSection
        .padding(.bottom, 20)
    }
    .alert(isPresented: $remindervm.isshowAlert, content: remindervm.getAlert)
  }
  
  func isPressedCreateReminer() {
    if remindervm.textCondition(){
      remindervm.addItem(title: remindervm.createReminderText, selectedColor: remindervm.selectedColor, reminderHours: remindervm.hours, reminderMinutes: remindervm.minutes)
      vm.addTasks(text: remindervm.taskTitle, taskDate: remindervm.taskDate)
      presentationMode.wrappedValue.dismiss()
    }
    
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
  private var inputTextTitleSection :some View{
    Text("Create a new remainder")
      .font(.title)
      .bold()
      .foregroundColor(Color.caltheme.secondaryText)
      .frame(maxWidth:.infinity, alignment: .leading)
      .padding(.horizontal)
  }
  @ViewBuilder
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
    Divider()
      .background(Color.caltheme.lightgray)
  }
  @ViewBuilder
  private var inputDateSection: some View{
    DatePicker("TaskDate", selection: $remindervm.taskDate, displayedComponents: .date)
      .font(.title3)
      .padding(.horizontal)
    Divider()
      .background(Color.caltheme.lightgray)
  }
  private var inputTimeSection: some View{
    HStack{
      Picker("", selection: $remindervm.hours){
        ForEach(0..<13, id:\.self){ i in
          Text("\(i) hours").tag(i)
            .font(.title)
        }
      }
      .frame(width: 200, height: 120).clipped()
      .pickerStyle(WheelPickerStyle())
      Picker("", selection: $remindervm.minutes){
        ForEach(0..<61, id:\.self){ i in
          if i % 5 == 0{
            Text("\(i) minutes").tag(i)
              .font(.title)
          }
        }
      }
      .frame(width: 200,height: 120).clipped()
      .pickerStyle(WheelPickerStyle())
    }
  }
  @ViewBuilder
  private var createdTaskTitleSection: some View{
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
              .foregroundColor(color == remindervm.selectedColor ? Color.white : Color.clear)
              .shadow(color: color == remindervm.selectedColor ? Color.white : Color.clear, radius: 5, x: 0, y: 0))
          .onTapGesture {
            withAnimation(.easeIn){
              remindervm.selectedColor = color
            }
          }
      }
      .frame(maxWidth:.infinity)
      .padding(.horizontal)
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
    .padding(.horizontal)
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
    .padding(.horizontal)
  }
}
