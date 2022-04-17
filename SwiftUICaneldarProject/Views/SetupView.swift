//
//  SetupView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/04/04.
//

import SwiftUI
import MessageUI

struct SetupView: View {
  @AppStorage("isDarkMode") var isDarkMode : String = "다크모드"
  @AppStorage("isCharStyle") var isCharStyle : String = ""
  @AppStorage("isSoundStyle") var isSoundStyle = 1327
  @EnvironmentObject var remindervm : ReminderViewModel
    
    @State var isShowMailView : Bool = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
  var body: some View {
          Form{
            Section(header: Text("스타일")
              .font(Font.custom(remindervm.isCharStyle, size: 18))){
                HStack {
                  Text("화면 스타일")
                        .font(Font.custom(remindervm.isCharStyle, size: 18))
                        .fontWeight(.bold)
                  Spacer()
                  Picker("", selection:$isDarkMode){
                    ForEach(remindervm.systemStyles){ item in
                      Text(item.mode)
                        .font(Font.custom(remindervm.isCharStyle, size: 18))
                        .tag(item.mode)
                    }
                  }
                }
                HStack {
                  Text("글자 스타일")
                    .font(Font.custom(remindervm.isCharStyle, size: 18))
                    .fontWeight(.bold)
                  Spacer()
                  Picker("", selection:$remindervm.isCharStyle){
                    ForEach(remindervm.charStyles){ item in
                      Text(item.title)
                        .font(Font.custom(remindervm.isCharStyle, size: 18))
                        .tag(item.char)
                    }
                  }
                }
              }
            Section(header: Text("사운드")
              .font(Font.custom(remindervm.isCharStyle, size: 18))){
                HStack {
                  Text("효과음")
                    .font(Font.custom(remindervm.isCharStyle, size: 18))
                    .fontWeight(.bold)
                  Spacer()
                  Picker("", selection:$isSoundStyle){
                    ForEach(remindervm.soundStyle){ item in
                      Text(item.soundTitle)
                        .font(Font.custom(remindervm.isCharStyle, size: 18))
                        .tag(item.soundNumber)
                    }
                  }
                }
              }
              Section(header: Text("E-mail")
                .font(Font.custom(remindervm.isCharStyle, size: 18))){
                    Button("Bug report", action: {
                        isShowMailView.toggle()
                    })
                    .disabled(!MFMailComposeViewController.canSendMail())
                    .sheet(isPresented: $isShowMailView) {
                                MailView(isShowing: self.$isShowMailView, result: self.$result)
                            }
                }//버그 리포트 메일 툴 입력
          }//form
          .navigationTitle("Settings ⚙️")
  }
}

struct SetupView_Previews: PreviewProvider {
  static var previews: some View {
    SetupView()
  }
}
