//
//  ReminderViewModel.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/16.
//

import Foundation
import Combine
import SwiftUI

class ReminderViewModel : ObservableObject{
  @Environment(\.presentationMode) var presentationMode
  @Published var tasks : [TaskModel] = []
  
  @Published var counter : Int = 0
  @Published var createReminderText : String = ""
  @Published var taskDate : Date = Date()
  @Published var taskTitle : String = ""
  @Published var hours : Int = 0
  @Published var minutes : Double = 0
  @Published var startAngle : Double = 0
  @Published var toAngle : Double = 180
  @Published var startProgress : CGFloat = 0
  @Published var toProgress : CGFloat = 0.5
  @Published var selectedColor : Color = Color.caltheme.red
  @Published var textalert : String = ""
  @Published var isshowAlert : Bool = false
  
  @Published var circle = [
    Color.caltheme.red,
    Color.caltheme.pink,
    Color.caltheme.green,
    Color.caltheme.yellow,
    Color.caltheme.blue,
  ]
  var cancellables = Set<AnyCancellable>()
  init(){
    setUpTimer()
  }
  func setUpTimer(){
    Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in
        self?.counter += 1
      }
      .store(in: &cancellables)
  }

  func uiScreen() -> CGRect{
    return UIScreen.main.bounds
  }
  func getAlert() -> Alert{
    Alert(title: Text(textalert))
  }
  func textCondition() -> Bool {
    if createReminderText.count < 2{
      textalert = "Please, insert at least 3 characters\n😅😅😅"
      isshowAlert = true
      return false
    } else {
      return true
    }
  }
  func TimeString(time: Int) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%01i:%02i", minutes, seconds)
  }
}
