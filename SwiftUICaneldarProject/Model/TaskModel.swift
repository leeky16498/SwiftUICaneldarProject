//
//  TaskModel.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import Foundation
import SwiftUI

struct Task : Identifiable {
    
    let id = UUID()
    let title : String
    let scheduledTime : Date = Date()
    let duration : Int? = nil
    
}

struct TaskTimeModel : Identifiable {
    
    let id = UUID()
    let task : [Task]
    let taskDate : Date
}

func getTaskDate(offset: Int) -> Date {
    
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

var tasksDemo : [TaskTimeModel] = [
    TaskTimeModel(task: [Task(title: "경윤 약속"), Task(title: "아키 약속")], taskDate: getTaskDate(offset: 1)),
    TaskTimeModel(task: [Task(title: "영희 약속"), Task(title: "철수 약속")], taskDate: getTaskDate(offset: 2)),
]


struct TaskModel: Identifiable {
    let id = UUID().uuidString
    let title : String
    var selectedColor : Color
    let remindedtime : CGFloat
}
