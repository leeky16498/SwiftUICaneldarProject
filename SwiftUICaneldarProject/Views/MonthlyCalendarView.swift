//
//  CalendarView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import SwiftUI

struct CalendarView: View {
    
    @Binding var currentDate : Date // HomeView, currentDate 바인딩
    
    @StateObject var vm = CalendarViewModel()
    
    let days : [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let column = Array(repeating: GridItem(.flexible()), count : 7)
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                Button(action: {
                    vm.currentMonth -= 1
                }, label: {
                    Image(systemName: "chevron.left.square.fill")
                })
                
                Text(vm.formatDate(currentDate: currentDate)[0])
                    .font(.headline)
                
                Text(vm.formatDate(currentDate: currentDate)[1])
                    .font(.title3.bold())
                
                Button(action: {
                    vm.currentMonth += 1
                }, label: {
                    Image(systemName: "chevron.right.square.fill")
                })
            } // hst : 연월 부
            
            LazyVGrid(columns: column, spacing: 20) {
                ForEach(vm.extractDate()) { value in
                    Text(value.day == -1 ? "" : "\(value.day)")
                        .font(.headline)
                }
            }
        } // vst : 일자 표시부
        .onChange(of: vm.currentMonth) { newValue in
            currentDate = vm.getCurrentMonth()
        }
    }
}

    
//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
