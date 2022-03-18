//
//  TaskDataService.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/16.
//

import Foundation
import CoreData

/*
 1. Container 생성 : MyCoreContainer -> NSPersistentContainer
 2. 퍼블리셔 생성
 3. Container 초기화 --> loadPersistentStores
 */

class TaskDataService:ObservableObject{
    let container : NSPersistentContainer
    let containerName : String = "TaskContainer"
    let entityName : String = "TaskEntity"
    
    @Published var savedEntity : [TaskEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Fail to load core data \(error)")
            }
        }
        fetchData()
    }
    
    func fetchData(){ // 초기 셋업
        let request = NSFetchRequest<TaskEntity>(entityName: entityName)
        do{
            savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Core data \(error)")
        }
    }
//    remindervm.addItem(selectedColor: selectedColor, reimderdtime: toProgress.roundCGFloat())
//    private func add(item: TaskModel){
//        let newData = TaskEntity(context: container.viewContext)
//        newData.content = content
//        newData.selectedColor = selectedColor
//        newData.remindedtime = remindedtime
//        saveCoreEntity()
//    }
    
    func saveCoreEntity(){
        do{
            try container.viewContext.save()
            fetchData()
        }catch let error {
            print("Error saving \(error)")
        }
    }
    
    func updateCoreEntity(entity : TaskEntity, text:String){
//        entity.title = text
        saveCoreEntity()
    }
    
    func deleteCoreEntity(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntity[index]
        container.viewContext.delete(entity)
        saveCoreEntity()
    }
    
}
