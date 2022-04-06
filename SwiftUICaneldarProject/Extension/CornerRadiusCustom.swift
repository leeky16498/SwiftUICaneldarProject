//
//  CornerRadiusCustom.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 06/04/2022.
//

import SwiftUI
import Foundation

struct RoundedCorner : Shape {
    
    var radius : CGFloat = .infinity
    var corners : UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    func cornerRadius(_ radius: CGFloat, corners : UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
}
