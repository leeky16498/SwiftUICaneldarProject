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
    let duration : Int
    
}

struct TaskTimeModel : Identifiable {
    
    let id = UUID()
    let task : [Task]
    let taskDate : Date
    
}
