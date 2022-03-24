//
//  TextTitle.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/24.
//

import SwiftUI

struct TextTitle: View {
  var textTitle : String
  var body: some View {
    Text(textTitle)
      .font(.title3)
      .bold()
      .foregroundColor(Color.caltheme.secondaryText)
      .frame(maxWidth:.infinity, alignment: .leading)
      .padding(.horizontal)
  }
}

struct TextTitle_Previews: PreviewProvider {
  static var previews: some View {
    TextTitle(textTitle: "Initial Value")
  }
}
