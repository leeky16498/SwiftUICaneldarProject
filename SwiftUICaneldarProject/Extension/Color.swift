//
//  Color.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import Foundation
import SwiftUI

extension Color {
    static let caltheme = CalTheme()
}

struct CalTheme{
    let green = Color("ColorGreen")
    let lightgray = Color("ColorLightGray")
    let pink = Color("ColorPink")
    let red = Color("ColorRed")
    let violet = Color("ColorViolet")
    let yellow = Color("ColorYellow")
    let blue = Color("ColorBlue")
    let secondaryText = Color("SecondaryTextColor")
    let black = Color("ColorBlack")
    let background = Color("BackgroundColor")
    let CalendarTextColor = Color("CalendarTextColor")
}

fileprivate extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}
extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}
