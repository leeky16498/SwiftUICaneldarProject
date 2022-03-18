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
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                ScrollView(.vertical, showsIndicators: false) {
                    CalendarView(currentDate: $currentDate)
                        .padding()
                }
                
                Button(action: {
                    self.isShowCreateReminderView.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(.gray)
                                .frame(width : 60, height : 60)
                        )
                })
                .sheet(isPresented : $isShowCreateReminderView) {
                    CreateReminderView()
                }
                .padding(50)
                
            }
            
            .navigationTitle("Planery 🥰")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
