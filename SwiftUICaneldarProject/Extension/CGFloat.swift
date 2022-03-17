//
//  Double.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/17.
//

import Foundation
import SwiftUI
extension Double {
    func roundDouble() -> String{
        return String(format: "%.0f", self)
    }
}

extension CGFloat {
    func roundCGFloat() -> String{
        return String(format: "%.0f", self * 60)
    }
}
