////
////  TimerTest.swift
////  SwiftUICaneldarProject
////
////  Created by Chuljin Hwang on 2022/03/18.
////
//
//import SwiftUI
//
//struct LoadedTimerView: View {
//    @StateObject var remindervm = ReminderViewModel()
//    @Binding var loadedRemindedtime : String
//    @State var timeRemaining : Int = 600
//    
    init(loadedRemindedtime: Binding<String>){
        _loadedRemindedtime = State(initialValue: "11")
        var ccc = Int(_loadedRemindedtime)!
        let aaa = 600
        _timeRemaining = State(initialValue: aaa)
    }
////    
//
//    
//    var body: some View {
//        VStack {
//
//            Text(loadedRemindedtime)
//            Text("\(TimeString(time: Int(loadedRemindedtime)!))")
//                .font(.largeTitle.bold())
//                .frame(maxWidth: .infinity)
//            
//                .foregroundColor(Color.caltheme.secondaryText)
//                .scaleEffect(1.5)
//            
//                .onReceive(remindervm.$counter){ _ in
//                    if self.timeRemaining > 0 {
//                        self.timeRemaining -= 1
//                    }else{
//    //                    remindervm.cancellables.cancel()
//    //                    self.timer.upstream.connect().cancel()
//                    }
//                }
//        }
//        
//    }
//    func TimeString(time: Int) -> String {
//        let minutes = Int(time) / 60 % 60
//        let seconds = Int(time) % 60
//        return String(format:"%01i:%02i", minutes, seconds)
//    }
//}
//
//struct LoadedTimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadedTimerView(loadedRemindedtime: .constant("11"))
//    }
//}
