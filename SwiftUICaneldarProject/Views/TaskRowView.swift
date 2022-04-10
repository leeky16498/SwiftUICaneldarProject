//
//  TaskRowView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 19/03/2022.
//

import SwiftUI

struct TaskRowView: View {
  @State private var isShowCreateTimerView : Bool = false
    
  @State var task : TaskModel
  
  var body: some View {
    HStack {
      VStack(alignment : .leading) {
          Text(task.title)
          .font(.title2.bold())
          
          Text("Scheduled time : \(task.remindedTime)mim")
              .font(.footnote)
              .foregroundColor(.gray)
              .padding(.bottom, 6)
          
          RoundedRectangle(cornerRadius: 20)
              .fill(.gray)
              .frame(height : 15)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.indigo)
                    .frame(width : 30)
                ,alignment: .leading
              )
              .overlay(
                Text("30%")
                    .font(.footnote)
              )
      }
      .padding(.leading, 35)
      
      Spacer()
      
      Button(action: {
        isShowCreateTimerView.toggle()
      }, label: {
        HStack{
          Image(systemName: "clock")
          Text("Timer")
        }
        .foregroundColor(.black)
        .frame(width: 110, height : 50)
        .background(.yellow)
        .cornerRadius(12)
      })
      .sheet(isPresented : $isShowCreateTimerView) {
        VStack{
          LoadedTimerView(item: task)
        }
      }
        .padding(.trailing, 40)
        .padding(.leading, 10)
      }//hst
      .frame(maxWidth : .infinity)
      .frame(height : 100)
      .background(.ultraThinMaterial)
      .overlay(
        Rectangle()
            .fill(task.selectedColor)
            .frame(width : 25)
            .cornerRadius(8, corners: [.topLeft, .bottomLeft])
        ,alignment: .leading
      )
      .cornerRadius(10)
      .offset(x: 20)
      .padding(.vertical, 3)

    }
  }
