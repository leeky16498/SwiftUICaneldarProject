//
//  TaskRowView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 19/03/2022.
//
import SwiftUI

struct TaskRowView: View {

    @State private var offsets : CGSize = .zero
    @State private var isSwipped : Bool = false
    @State private var isShowCreateTimerView : Bool = false
    @EnvironmentObject var vm : CalendarViewModel
    let task : TaskModel
    @State private var isShowEditSheet : Bool = false
    @State private var isSelectedToDelete : Bool = false
  
  var body: some View {
      ZStack {
          Color.white
          HStack(spacing: 0) {
              Spacer()
              Button(action: {
                  isShowEditSheet.toggle()
              }, label: {
                  Image(systemName: "pencil")
                      .foregroundColor(.white)
                      .font(.title)
                      .frame(width : 70, height : 100)
                      .background(.green)
              })
              .sheet(isPresented: $isShowEditSheet) {
                  CreateReminderView(task: task)
              }
              
              Button(action: {
                  vm.deleteTask(task: task)
              }, label: {
                  Image(systemName: "trash")
                      .foregroundColor(.white)
                      .font(.title)
                      .frame(width : 70, height : 100)
                      .background(.red)
                     
              })
          }
          
          HStack {
            VStack(alignment : .leading) {
                Text(task.title)
                .font(.title2.bold())
                .padding(.vertical, 3)
                
                Text(task.content)
                    .font(.footnote)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .padding(.bottom, 3)
                
                Text("Planned time : \(task.taskDate.formatted(date: .omitted, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 6)
            }
            .padding(.leading, 35)
            
            Spacer()
            }//hst
            .frame(maxWidth : .infinity)
            .frame(height : 100)
            .background(Color.init(uiColor: .white))
            .overlay(
              Rectangle()
                  .fill(task.selectedColor)
                  .frame(width : 25)
                  .cornerRadius(8, corners: [.topLeft, .bottomLeft])
              ,alignment: .leading
            )
            .cornerRadius(10, corners: [.topLeft, .bottomLeft])
            .offset(x : offsets.width)
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        withAnimation(.spring()) {
                            if gesture.translation.width < 0 {
                                if isSwipped {
                                    offsets.width = gesture.translation.width - 140
                                } else {
                                    offsets.width = gesture.translation.width
                                }
                            }
                        }
                    })
                    .onEnded({ gesture in
                        withAnimation(.spring()) {
                            if gesture.translation.width < 0 {
                                if gesture.translation.width < -20 {
                                    isSwipped = true
                                    offsets.width = -140
                                } else {
                                    isSwipped = false
                                    offsets.width = 0
                                }
                            } else {
                                isSwipped = false
                                offsets.width = 0
                            }
                        }
                    })
            )
        }//zst
      .border(width: 1, edges: [.bottom, .top, .leading], color:  .gray)
      .cornerRadius(10, corners: [.topLeft, .bottomLeft])
      .padding(.leading, 20)
      .onTapGesture {}
      .onLongPressGesture {
          self.isSelectedToDelete.toggle()
      }
      .confirmationDialog("Option", isPresented: $isSelectedToDelete) {
          Button(role: .destructive, action: {
              vm.deleteTask(task: task)
          }, label: {
              Text("Delete")
          })
      }
    }
}
