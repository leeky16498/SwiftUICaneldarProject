//
//  TaskModel.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import Foundation
import SwiftUI

<<<<<<< HEAD
struct Task : Identifiable {
    
    let id = UUID()
    let title : String
    let scheduledTime : Date
    let duration : Int
    
}

struct TaskTimeModel : Identifiable {
    
    let id = UUID()
    let task : [Task]
    let taskDate : Date
    
=======
struct TaskModel: Identifiable {
    let id = UUID().uuidString
    let content : String
    var selectedColor : Color
    let remindedtime : String
>>>>>>> dc9e35a1636016db4c89c954e5bc1ef071197aaf
}
