//
//  SetupView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/04/04.
//

import SwiftUI

struct SetupView: View {
  @AppStorage("isDarkMode") var isDarkMode : String = "다크모드"
  @AppStorage("isCharStyle") var isCharStyle : String = ""
  @AppStorage("isSoundStyle") var isSoundStyle = 1327
  @EnvironmentObject var remindervm : ReminderViewModel
  var body: some View {
    NavigationView{
      List{
        Section(header: Text("스타일")
          .font(Font.custom(remindervm.isCharStyle, size: 20))){
            HStack {
              Text("화면 스타일")
                .font(Font.custom(remindervm.isCharStyle, size: 20))
              Spacer()
              Picker("", selection:$isDarkMode){
                ForEach(remindervm.systemStyles){ item in
                  Text(item.mode)
                    .font(Font.custom(remindervm.isCharStyle, size: 20))
                    .tag(item.mode)
                }
              }
            }
            HStack {
              Text("글자 스타일")
                .font(Font.custom(remindervm.isCharStyle, size: 20))
              Spacer()
              Picker("", selection:$remindervm.isCharStyle){
                ForEach(remindervm.charStyles){ item in
                  Text(item.title)
                    .font(Font.custom(remindervm.isCharStyle, size: 20))
                    .tag(item.char)
                }
              }
            }
          }
        Section(header: Text("소리")
          .font(Font.custom(remindervm.isCharStyle, size: 20))){
            HStack {
              Text("효과음")
                .font(Font.custom(remindervm.isCharStyle, size: 20))
              Spacer()
              Picker("", selection:$isSoundStyle){
                ForEach(remindervm.soundStyle){ item in
                  Text(item.soundTitle)
                    .font(Font.custom(remindervm.isCharStyle, size: 20))
                    .tag(item.soundNumber)
                }
              }
            }
          }
      }
    }

  }
}

struct SetupView_Previews: PreviewProvider {
  static var previews: some View {
    SetupView()
  }
}
