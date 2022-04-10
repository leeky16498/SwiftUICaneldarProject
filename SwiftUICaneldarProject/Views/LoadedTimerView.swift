//
//  LoadedTimerView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/24.
//

import SwiftUI

struct LoadedTimerView: View {
  @Environment(\.presentationMode) var presentationMode
  @State var item : TaskModel
  @EnvironmentObject var remindervm : ReminderViewModel
  var body: some View {
    VStack{
      TextTitleSection
      clockSection
      timeTextSection
      buttonSection
    }
  }
  func TimeString(time: Int) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%01i:%02i", minutes, seconds)
  }
  
}


struct LoadedTimerView_Previews: PreviewProvider {
  static var previews: some View {
    let item1 = TaskModel(title: "Home", content: "Hello",selectedColor: Color.caltheme.pink, remindedTime: 30, taskDate: Date())
    LoadedTimerView(item: item1)
      .preferredColorScheme(.dark)
      .environmentObject(ReminderViewModel())
  }
}

extension LoadedTimerView{
  private var TextTitleSection :some View{
    Text(item.title)
      .font(.largeTitle)
      .bold()
      .foregroundColor(Color.caltheme.secondaryText)
      .frame(maxWidth:.infinity, alignment: .center)
      .padding(.horizontal)
  }
  private var clockSection : some View{
    ZStack{
      Circle()
        .frame(width: remindervm.uiScreen().width * 0.9, height: remindervm.uiScreen().width * 0.9, alignment: .center)
        .shadow(color: item.selectedColor, radius: 20, x: 0, y: 0)
      Circle()
        .frame(width: remindervm.uiScreen().width * 0.7, height: remindervm.uiScreen().width * 0.7, alignment: .center)
        .foregroundColor(Color.caltheme.black.opacity(0.85))
      ForEach(0..<60, id:\.self){i in
        Rectangle()
          .foregroundColor(Color.white)
          .frame(width: i % 5 == 0 ? 15 : 5, height:  1)
          .offset(x: (remindervm.uiScreen().width * 0.6) / 2)
          .rotationEffect(.init(degrees: Double(i) * 6))
      }
      FillClock(startAngle: remindervm.startAngle, toAngle: Double(item.remindedTime / 60 * 6))
        .fill(item.selectedColor)
        .frame(width: remindervm.uiScreen().width * 0.9, height: remindervm.uiScreen().width * 0.9)
        .offset(y: (remindervm.uiScreen().width * 0.9 ) / 2)
        .rotationEffect(Angle(degrees: -90))
    }
    .padding(.vertical,30)
  }
  private var timeTextSection: some View{
    HStack(spacing : 0) {
      Text("\(TimeString(time: item.remindedTime))")
        .frame(width:100)
//      Text("Minutes")
//        .frame(width:130)
    }
    .font(.largeTitle.bold())
    .foregroundColor(Color.caltheme.secondaryText)
    .padding()
    .scaleEffect(1.2)
    .onReceive(remindervm.$counter){ _ in
      if remindervm.timerstyle == .start{
        if item.remindedTime > 0 {
          item.remindedTime -= 1
          }
      }else if remindervm.timerstyle == .pause{
        
      }else if remindervm.timerstyle == .stop{
        item.remindedTime = 0
      }
//      if item.remindedTime > 0 {
//        item.remindedTime -= 1
//        }else{
//
//        }
    }
  }
  

  private var buttonSection: some View{
    HStack(spacing:40) {
      Button(action: {
        if  remindervm.timerstyle == .start && item.remindedTime != 0{
          remindervm.timerstyle = .pause
        } else if remindervm.timerstyle == .pause && item.remindedTime != 0 {
          remindervm.timerstyle = .start
        }
       
      }, label: {
        Image(systemName: remindervm.timerstyle == .start ?  "pause.fill" : "play.fill" )
          .font(.system(size:40))
      })
      .frame(width:150,height:80, alignment: .center)
      .foregroundColor(Color.caltheme.secondaryText)
      .background(item.selectedColor)
      .cornerRadius(15)
      Button(action: {
        remindervm.timerstyle = .stop
        
      }, label: {
        Image(systemName: "stop.fill")
          .font(.system(size:40))
      })
      .frame(width:150,height:80, alignment: .center)
      .foregroundColor(Color.caltheme.secondaryText)
      .background(item.selectedColor)
      .cornerRadius(15)
    }
  }
  
}

