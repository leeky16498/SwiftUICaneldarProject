//
//  LoadedReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/17.
//

import SwiftUI
import CoreData
struct LoadedReminderView: View {
    @StateObject var remindervm = ReminderViewModel()
    @State private var startProgress : CGFloat
    @State private var toProgress : CGFloat = 0.5
    @State private var startAngle : Double
    @State private var toAngle : Double = 180
    @State var selectedColor : Color
    @State var timeRemaining : Int = 600
    
//    var loadedContent : String
//    var loadedSelectedColor : String
//    var loadedRemindedtime : String
//
//    init(loadedRemindedtime: Binding<String>){
//        _loadedRemindedtime = State(initialValue: "11")
//        var ccc = Int(_loadedRemindedtime)!
//        let aaa = 600
//        _timeRemaining = State(initialValue: aaa)
//    }
    
    
    var body: some View {
        VStack{
//            Text(loadedSelectedColor)
                
            inputTextTitle
            
            Divider()
                .padding(.bottom,10)
//            clockSection
                .padding(.vertical,10)
            timeTextSection
                .padding(.vertical,10)
            buttonSection
            .foregroundColor(Color.white)
            .padding(.top,30)
        } //VSTACK
//        .navigationBarHidden(true)
        
    }
    
    func TimeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i", minutes, seconds)
    }
}


//struct LoadedReminderView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadedReminderView(toProgress: 1.1, selectedColor: Color.red)
//            .preferredColorScheme(.dark)
//    }
//}


extension LoadedReminderView {
    private var inputTextTitle :some View{
        Text("he")
            .font(.largeTitle)
            .bold()
            .foregroundColor(Color.caltheme.secondaryText)
            .frame(maxWidth:.infinity, alignment: .center)
            .padding(.horizontal)
    }
    private var clockSection : some View{
        ZStack{
            Circle()
                .frame(width: remindervm.uiScreen().width * 0.9, height: remindervm.uiScreen().width * 0.9, alignment: .center)
                .shadow(color: Color.caltheme.pink, radius: 20, x: 0, y: 0)
            //드레그 할때 움직이는 아이
            
            Circle()
                .frame(width: remindervm.uiScreen().width * 0.7, height: remindervm.uiScreen().width * 0.7, alignment: .center)
                .foregroundColor(Color.caltheme.black.opacity(0.85))
            ForEach(0..<60, id:\.self){i in
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: i % 5 == 0 ? 15 : 5, height:  1)
                    .offset(x: (remindervm.uiScreen().width * 0.6) / 2)
                    .rotationEffect(.init(degrees: Double(i) * 6))
            }
            
            let texts = [6,9,12,3]
            
            ForEach(texts.indices, id: \.self){index in
                Text("\(texts[index])")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: Double(index) * -90))
                    .offset(y:(remindervm.uiScreen().width * 0.25))
                    .rotationEffect(Angle(degrees: Double(index) * 90))
            }
            
            ForEach(1..<361, id: \.self){ sec in
                Rectangle()
                    .frame(width: 20, height: 1)
                    .foregroundColor(Color.caltheme.pink)
                    .offset(x: (remindervm.uiScreen().width * 0.8 ) / 2)
                    .rotationEffect(Angle(degrees: Double(sec)))
            }
            
            Rectangle()
                .frame(width: 130, height: 3)
                .foregroundColor(Color.caltheme.pink)
                .offset(x: 60)
                .rotationEffect(Angle(degrees: Double(toAngle - 90 )))
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(Color.caltheme.pink)
            
        }
    }
    
    private var timeTextSection: some View{
        VStack {

            Text("he")
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
    }
    
    private var buttonSection: some View{
        HStack(spacing:40) {
            Button(action: {
                
            }, label: {
                Image(systemName: "playpause.fill")
                    .font(.system(size:40))
//                    Text("Play")
//                        .font(.system(.title, design: .rounded))
//                        .fontWeight(.bold)
            })
            .frame(width:150,height:80, alignment: .center)
            .background(Color.caltheme.red)
            .cornerRadius(15)
            
            Button(action: {
     
            }, label: {
                Image(systemName: "stop.fill")
                    .font(.system(size:40))
//                    Text("Stop")
//                        .font(.system(.title, design: .rounded))
//                        .fontWeight(.bold)
            })
            .frame(width:150,height:80, alignment: .center)
            .background(Color.caltheme.red)
            .cornerRadius(15)
        }
    }
}

