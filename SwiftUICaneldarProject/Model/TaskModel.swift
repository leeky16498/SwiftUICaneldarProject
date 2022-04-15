//
//  TaskModel.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import Foundation
import SwiftUI


struct TaskModel: Identifiable, Codable {
  var id = UUID().uuidString
  var title : String
  var content : String
  var selectedColor : Color
  var remindedTime : Int
  var taskDate : Date
    
    func editedItem(title : String, content : String, selectedColor : Color, taskDate : Date) -> TaskModel {
        return TaskModel(id: id, title: title, content: content, selectedColor: selectedColor, remindedTime: remindedTime, taskDate: taskDate)
    }
}



struct CharStyles : Identifiable{
  let id = UUID().uuidString
  var title : String
  var char : String
}
struct SystemStyle : Identifiable{
  let id = UUID().uuidString
  var mode : String
}
struct SoundStyle : Identifiable{
  let id = UUID().uuidString
  let soundTitle : String
  let soundNumber : Int
}


