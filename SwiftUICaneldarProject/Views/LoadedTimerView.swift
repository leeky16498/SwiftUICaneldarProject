//
//  TimerTest.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/18.
//

import SwiftUI
import Combine
struct LoadedTimerView: View {

    @Binding var loadedRemindedtime : String
    @State var timeRemaining : Int = 600
    @StateObject var remindervm = ReminderViewModel()
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
 
    var body: some View {
        Text(loadedRemindedtime)
        Text("\(TimeString(time: timeRemaining))")
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity)
        
            .foregroundColor(Color.caltheme.secondaryText)
            .scaleEffect(1.5)
        
            .onReceive(remindervm.$counter){ _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }else{
                    
//                    remindervm.cancellables.cancel()
//                    self.timer.upstream.connect().cancel()
                }
            }
    }
    func TimeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i", minutes, seconds)
    }
}

struct LoadedTimerView_Previews: PreviewProvider {
    static var previews: some View {
        LoadedTimerView(loadedRemindedtime: .constant("600"))
    }
}
