//
//  ReminderViewModel.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/16.
//

import Foundation
import Combine

class ReminderViewModel : ObservableObject{
    @Published var counter : Int = 0
    var cancellables = Set<AnyCancellable>()
    init(){
        setUpTimer()
    }
    func setUpTimer(){
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.counter += 1
            }
            .store(in: &cancellables)
    }
}
