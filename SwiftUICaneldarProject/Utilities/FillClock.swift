//
//  FillClock.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/22.
//

import Foundation
import SwiftUI
struct FillClock: Shape {
    @StateObject var vm = ReminderViewModel()
    @State var startAngle : Double = 0.0
    @State var toAngle : Double = 0.0
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.minY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 360 - startAngle),
                endAngle: Angle(degrees: toAngle),
                clockwise: false)
        }
    }
}
