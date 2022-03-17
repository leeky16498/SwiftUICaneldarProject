//
//  TaskModel.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import Foundation
import SwiftUI

struct TaskModel: Identifiable {
    let id = UUID().uuidString
    let content : String
    var selectedColor : Color
    let remindedtime : String
}
