//
//  HomeView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import SwiftUI

struct HomeView: View {
  
  @State var currentDate : Date = Date()
  @State var isShowCreateReminderView : Bool = false
  @EnvironmentObject var vm : CalendarViewModel
  
  var body: some View {
    NavigationView{
      ZStack(alignment: .bottomTrailing){
        ScrollView(.vertical, showsIndicators: false) {
          CalendarView(currentDate: $currentDate)
            .padding()
          
            if vm.tasks.filter({vm.isSameDay(date1: $0.taskDate, date2: currentDate)}).count != 0 {
                HStack {
                  Text("Today's Plan")
                    .font(.title.bold())

                  
                  Spacer()
                }
                .padding(.horizontal)
                
                Rectangle()
                  .fill(.gray)
                  .frame(maxWidth : .infinity)
                  .frame(height : 2)
                  .padding(.horizontal)
                  .padding(.bottom, 10)
                
                VStack {
                    ForEach(vm.tasks.filter({vm.isSameDay(date1: $0.taskDate, date2: currentDate)})) { task in
                        TaskRowView(task: task)
                    }
                 }
              }
            }
//        Button(action: {
//          self.isShowCreateReminderView.toggle()
//        }, label: {
//          Image(systemName: "plus")
//            .font(.title3.bold())
//            .foregroundColor(.white)
//            .background(
//              Circle()
//                .fill(.gray)
//                .frame(width : 60, height : 60)
//            )
//        })
//        .sheet(isPresented : $isShowCreateReminderView) {
//          VStack{
//
//            CreateReminderView()
//          }
//        }
      }
        
      .navigationTitle("Planery🥰")
      .toolbar {
          ToolbarItemGroup(placement: .navigationBarTrailing) {
              HStack{
                  Button(action: {
                      self.isShowCreateReminderView.toggle()
                  }, label: {
                      Image(systemName: "plus")
                  })
                  .sheet(isPresented: $isShowCreateReminderView) {
                      CreateReminderView()
                  }
                  
                  NavigationLink(destination: {
                      SetupView()
                  }, label: {
                      Image(systemName: "gear")
                  })
              }
          }
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .preferredColorScheme(.dark)
      .environmentObject(CalendarViewModel())
  }
}
