//
//  CalendarView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import SwiftUI

struct CalendarView: View {
    
    @Binding var currentDate : Date // HomeView, currentDate 바인딩
    @State var isAnimating : Bool = false
    
    @EnvironmentObject var vm : CalendarViewModel
    
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
                    .font(.title2)
                    .fontWeight(.heavy)
                
                Button(action: {
                    vm.currentMonth += 1
                }, label: {
                    Image(systemName: "chevron.right.square.fill")
                })
            } // hst : 연월 부
            
            HStack {
                ForEach(days, id: \.self) {day in
                    Text(day)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: column, spacing: 20) {
                ForEach(vm.extractDate()) { value in
                    cardView(value: value)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.ultraThinMaterial)
                                .opacity(vm.isSameDay(date1: value.date, date2: currentDate) ? 1 : 0) // 달력 면
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: isAnimating ? 1 : 1.5)
                                .opacity(vm.isSameDay(date1: value.date, date2: currentDate) ? 1 : 0) // 달력 선
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
        } // vst : 일자 표시부
        .onChange(of: vm.currentMonth) { newValue in
            currentDate = vm.getCurrentMonth()
        }
    }
}

extension CalendarView {
    
    @ViewBuilder
    func cardView(value : DateModel) -> some View {
        
        VStack {
            if value.day != -1 {
                if let task = vm.tasks.first(where: { task in
                    return vm.isSameDay(date1: task.taskDate, date2: value.date)
                }) {
                    
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(vm.isSameDay(date1: task.taskDate, date2: currentDate) ? .mint : Color.caltheme.CalendarTextColor)
                        .frame(maxWidth : .infinity)
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(vm.isSameDay(date1: task.taskDate, date2: value.date) ? .mint.opacity(0.3) : Color.caltheme.CalendarTextColor)
                        .frame(width : 25, height : 25)
                        .padding(.bottom, 3)
                        .overlay(
                            Text("+\(vm.tasks.filter({vm.isSameDay(date1: $0.taskDate, date2: value.date)}).count)")
                                .font(.system(size: 9).bold())
                            ,alignment: .center
                        )
                   
                } else {
                    if Calendar.current.component(.weekday, from: value.date) == 1 {
                        Text("\(value.day)")
                            .font(.title3.bold())
                            .foregroundColor(vm.isSameDay(date1: value.date, date2: currentDate) ? .mint : .red)
                            .frame(maxWidth : .infinity)
                    } else if Calendar.current.component(.weekday, from: value.date) == 7 {
                        Text("\(value.day)")
                            .font(.title3.bold())
                            .foregroundColor(vm.isSameDay(date1: value.date, date2: currentDate) ? .mint : .blue)
                            .frame(maxWidth : .infinity)
                    } else {
                        Text("\(value.day)")
                            .font(.title3.bold())
                            .foregroundColor(vm.isSameDay(date1: value.date, date2: currentDate) ? .mint : Color.caltheme.CalendarTextColor)
                            .frame(maxWidth : .infinity)
                    }
                    Spacer()
                }
            }
        } // vst
        .padding(.vertical, 5)
        .frame(height : 70, alignment : .top)
    }
}

    
//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
