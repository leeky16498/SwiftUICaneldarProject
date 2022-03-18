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
    @State private var startProgress : CGFloat = 0
    @State private var toProgress : CGFloat = 0.5
    @State private var startAngle : Double = 0
    @State private var toAngle : Double = 180
    var body: some View {
        VStack{
//            remindervm.savedEntity.remindedtime.map(Text.init)
            inputTextTitle
            
            Divider()
                .padding(.bottom,10)
            clockSection
                .padding(.vertical,10)
            timeTextSection
                .padding(.vertical,10)
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
            .foregroundColor(Color.white)
            .padding(.top,30)
        } //VSTACK
        
    }
}


struct LoadedReminderView_Previews: PreviewProvider {
    static var previews: some View {
        LoadedReminderView()
            .preferredColorScheme(.dark)
    }
}


extension LoadedReminderView {
    private var inputTextTitle :some View{
        Text("the name of your task")
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
                .trim(from: startProgress, to: toProgress)
                .stroke(Color.caltheme.pink, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                .frame(width: remindervm.uiScreen().width * 0.8, height: remindervm.uiScreen().width * 0.8, alignment: .center)
                .rotationEffect(Angle(degrees: -90))
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
        HStack(spacing : 0) {
            Text("50")
                .frame(width:50)
            Text("Minutes")
                .frame(width:130)
        }
        .font(.largeTitle.bold())
        .foregroundColor(Color.caltheme.secondaryText)
        .padding()
        .scaleEffect(1.5)
    }
}

