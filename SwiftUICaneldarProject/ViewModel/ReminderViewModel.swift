//
//  ReminderViewModel.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/16.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class ReminderViewModel : ObservableObject{
    @Published var counter : Int = 0
    @Published var createReminderText : String = ""
    @Published var savedEntity : [TaskEntity] = []
    @Published var circle = [
        Color.caltheme.red,
        Color.caltheme.pink,
        Color.caltheme.green,
        Color.caltheme.yellow,
        Color.caltheme.blue,
    ]
   
    let container : NSPersistentContainer
    var cancellables = Set<AnyCancellable>()
    init(){
        container = NSPersistentContainer(name: "TaskContainer")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Fail to load core data \(error)")
            }
        }
        fetchData()
        setUpTimer()
    }
    func setUpTimer(){
        let sub =  Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.counter += 1
            }
            .store(in: &cancellables)
    }

    func fetchData(){ // 초기 셋업
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        do{
            savedEntity = try container.viewContext.fetch(request)
            print(savedEntity)
        } catch let error {
            print("Error fetching Core data \(error)")
        }
    }
    
    
    func addItem(selectedColor: Color, reimderdtime : String){
        let entity = TaskEntity(context: container.viewContext)
        entity.selectedColor = selectedColor.description
        entity.remindedtime = reimderdtime
//        if let intreimderdtime = Int(reimderdtime){
//            entity.remindedtime = Int16(intreimderdtime)
//        }
        saveCoreEntity()
//        print(entity.remindedtime)

    }
    func saveCoreEntity(){
        do{
            try container.viewContext.save()
            fetchData()
        }catch let error {
            print("Error saving \(error)")
        }
    }

    
//    func updateCoreEntity(entity : TaskEntity, text:String){
////        entity.title = text
//        saveCoreEntity()
//    }
    
 
    
    func deleteCoreEntity(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntity[index]
        container.viewContext.delete(entity)
        saveCoreEntity()
    }
    
    func uiScreen() -> CGRect{
        return UIScreen.main.bounds
    }
    
    
    

    



}
