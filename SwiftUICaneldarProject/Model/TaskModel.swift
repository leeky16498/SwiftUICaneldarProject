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
    let scheduledTime : Date
    let duration : Int? = nil
    
}

struct TaskTimeModel : Identifiable {
    
    let id = UUID()
    var task : [Task] = []
    let taskDate : Date
}

func getTaskDate(offset: Int) -> Date {
    
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

//var demoDate : Date {
//    let stringDate = "2022-03-10"
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    let date = dateFormatter.date(from: stringDate)
//    return date!
//}


struct TaskModel: Identifiable {
    let id = UUID().uuidString
    let title : String
    var selectedColor : Color
    let remindedtime : CGFloat
}
