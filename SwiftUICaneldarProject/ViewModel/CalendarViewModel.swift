//
//  CalendarViewModel.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import Foundation
import SwiftUI

class CalendarViewModel : ObservableObject {
    
    @Published var tasks : [TaskModel] = []
    @Published var currentMonth : Int = 0
    

    func addTask(title : String, selectedColor : Color, reminderTime : Int, taskDate : Date) {
        let newTask = TaskModel(title: title, selectedColor: selectedColor, remindedTime: reminderTime * 60, taskDate: taskDate)
        tasks.append(newTask)
    }
    
    func getCurrentMonth() -> Date { // 유저가 원하는 현재 month를 뽑아내는 메소드
        
        let calendar  = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {return Date()}
        
        return currentMonth
    }
    
    func extractDate() -> [DateModel] { // 유저가 선택한 연월의 일자를 뽑아내는 메소드
        
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date  -> DateModel in
            let day = calendar.component(.day, from: date)
            return DateModel(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateModel(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    func formatDate(currentDate : Date) -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM" // 포맷형태 지정 후,
        
        let date = formatter.string(from: currentDate) // 날짜의 포맷을 연결해주고
        
        return date.components(separatedBy: " ") // 날짜의 포맷형을 " " 로 분할된 문자열 기반 배열로 리턴해준다.
    }
    
    func isSameDay(date1 : Date, date2 : Date) -> Bool { // 유저가 선택한 날짜와 현재 날짜의 일치여부를 확인하는 메소드(불리언 리턴)
        
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
}
