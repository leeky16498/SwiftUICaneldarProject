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
          .foregroundColor(.white)
          
          Text("Scheduled time : \(task.remindedTime)시간")
          
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
      .padding(.leading, 25)
      
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
      }
      .frame(maxWidth : .infinity)
      .frame(height : 120)
      .background(.ultraThinMaterial)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
            .fill(task.selectedColor)
            .frame(width : 12)
        ,alignment: .leading
      )
      .cornerRadius(10)
      .offset(x: 20)
      .padding(.vertical, 3)
    }
  }
  
//  struct TaskRowView_Previews: PreviewProvider {
//    static var tasks : Task = Task(title: "hello", scheduledTime: Date())
//    static var previews: some View {
//      TaskRowView(task: tasks)
//        .previewLayout(.sizeThatFits)
//        .preferredColorScheme(.dark)
//    }
//  }
