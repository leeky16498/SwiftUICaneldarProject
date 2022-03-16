//
//  getAllDate.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import Foundation

extension Date {
    
    func getAllDates() -> [Date] { // 해당 월의 모든 날을 체크하여 배열을 통해 가져오는 메소드
        
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let dateRange = calendar.range(of: .day, in: .month, for: startDate)!
        
        return dateRange.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
