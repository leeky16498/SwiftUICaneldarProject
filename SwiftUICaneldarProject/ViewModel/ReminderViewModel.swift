//
//  ReminderViewModel.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/16.
//

import Foundation
import Combine
import SwiftUI

class ReminderViewModel : ObservableObject{
    @Published var counter : Int = 0
    @Published var taskmodel : [TaskModel] = []
    @Published var createReminderText : String = ""
    @Published var circle = [
        Color.caltheme.red,
        Color.caltheme.pink,
        Color.caltheme.green,
        Color.caltheme.yellow,
        Color.caltheme.blue,
    ]

    var cancellables = Set<AnyCancellable>()
    
    init(){
        setUpTimer()
    }
    
    func getData(){
        //코어에서 가져올꺼야
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
    
    func addItem(selectedColor: Color, reimderdtime : String){
        let addItem = [TaskModel(content: createReminderText, selectedColor: selectedColor, remindedtime: reimderdtime)]
        taskmodel.append(contentsOf: addItem)
        print(addItem)
    }
    
    func uiScreen() -> CGRect{
        return UIScreen.main.bounds
    }
    
}
