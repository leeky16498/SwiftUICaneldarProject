//
//  test.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/04/14.
//

import SwiftUI

struct DragList: View {
  @State private var offsets : CGSize = .zero
  @State private var trashOffset : CGFloat = 80
  var body: some View {
    VStack{
      Text("\(offsets.width)")
      ZStack{
        Rectangle()
              .foregroundColor(Color.red)
              .frame(maxWidth:.infinity)
              .padding(.leading,20)
              .cornerRadius(10)
              .opacity(offsets.width == 0 ? 0 : 1)
        HStack(spacing:0){
          Spacer()
          Button {
          } label: {
              Image(systemName: "trash")
                .foregroundColor(.white)
                .font(.title)
                .frame(width : 70, height : 70)
                .background(.red)
                .padding(.trailing,5)
                .offset(x: trashOffset)
                .offset(x: offsets.width <= -70 ? -70 : offsets.width)
          }
        }
        HStack{
          Text("Test")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
          Spacer()
        }
        .frame(maxWidth : .infinity)
        .frame(height : 70)
        .background(Color.yellow)
        .cornerRadius(10)
        .padding(.horizontal,5)
        .offset(x : offsets.width)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    withAnimation(.spring()) {
                      withAnimation(.spring()){
                        offsets.width = gesture.translation.width - 70
                      }
                    }
                })
                .onEnded({ gesture in
                    withAnimation(.spring()) {
                      if  -200 < gesture.translation.width  && gesture.translation.width < -20 {
                        offsets.width = -70
                      }else if gesture.translation.width < -200 {
                        //call delete
                        offsets.width = -70
                      }else if gesture.translation.width > 0 {
                        offsets.width = 0
                      }
                    }
                })
        )
      }
      .frame(maxWidth:.infinity)
      .frame(height: 70)
    }
    
  }
}

struct DragList_Previews: PreviewProvider {
  static var previews: some View {
    DragList()
  }
}
