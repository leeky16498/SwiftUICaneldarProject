//
//  ReminderListView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/18.
//

import SwiftUI
import CoreData
struct ReminderListView: View {
    @StateObject var remindervm = ReminderViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(remindervm.savedEntity){entity in
                        NavigationLink(destination: {
                            LoadedReminderView(loadedContent: entity.content ?? "hello", loadedSelectedColor: entity.selectedColor ?? "LLL", loadedRemindedtime: entity.remindedtime ?? "aaa")
                        }, label: {
                            Text(entity.content ?? "1 no")
                        })
                            
                           
                    
                    }
                    .onDelete(perform: remindervm.deleteCoreEntity)
                }
                .navigationBarTitle("Help me")
            }
 
            
           
        }
      
      
    }
}

struct ReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
    }
}
