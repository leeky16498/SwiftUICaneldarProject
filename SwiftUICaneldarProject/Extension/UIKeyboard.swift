//
//  UIKeyboard.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import Foundation
import SwiftUI
extension UIApplication{
    func closeKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for: nil)
    }
}
