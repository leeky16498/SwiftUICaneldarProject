//
//  CreateReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import SwiftUI

struct CreateReminderView: View {
    
    @StateObject var remindervm = ReminderViewModel()
    //    @Binding var createReminderText:String
    
    @State private var startAngle : Double = 0
    @State private var toAngle : Double = 180
    @State private var startProgress : CGFloat = 0
    @State private var toProgress : CGFloat = 0.5
    
    @State private var selectedColor : Color = Color.caltheme.red
    
    
    var body: some View {
        
    
            VStack{
                inputTextTitle
                inputTextSection
                Divider()
                    .padding(.bottom,10)
                colorTextSection
                colorCircleSection
                    .padding(.bottom,10)
                clockSection
                timeTextSection
                createButtonSection
            } //VSTACK
            
        
    }
    func uiScreen() -> CGRect{
        return UIScreen.main.bounds
    }
    func onDrag(value: DragGesture.Value){
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        var angle = radians * 180 / .pi
        if angle < 0 {angle += 360}
        let progress = angle / 360
        
        self.toAngle = angle
        self.toProgress = progress
    }
}

struct CreateReminderView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReminderView()
            .preferredColorScheme(.dark)
    }
}
extension CreateReminderView {
    private var inputTextTitle :some View{
        Text("Create a new remainder")
            .font(.title)
            .bold()
            .foregroundColor(Color.caltheme.secondaryText)
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(.horizontal)
    }
    private var inputTextSection : some View{
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(selectedColor)
            TextField("할일을 입력해주세요", text: $remindervm.createReminderText)
                .foregroundColor(
                    remindervm.createReminderText.isEmpty ?
                    Color.caltheme.secondaryText : Color.caltheme.violet)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.caltheme.violet)
                        .opacity(remindervm.createReminderText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.closeKeyboard()
                            remindervm.createReminderText = ""
                        }
                    
                    ,alignment:  .trailing
                )
        }
        .font(.title3)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.caltheme.background)
                .shadow(color: Color.caltheme.black.opacity(0.5), radius: 10, x: 0, y: 0)
        )
        .padding(.horizontal)
    }
    private var colorTextSection: some View{
        Text("Select the reminder color")
            .frame(maxWidth:.infinity, alignment: .leading)
            .font(.headline)
            .foregroundColor(Color.caltheme.secondaryText)
            .padding(.horizontal)
    }
    private var colorCircleSection: some View{
        HStack(spacing:5){
            ForEach(remindervm.circle, id:\.self){color in
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(color)
                    .background(
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(color == selectedColor ? Color.white : Color.clear)
                            .shadow(color: color == selectedColor ? Color.white : Color.clear, radius: 5, x: 0, y: 0))
                    .onTapGesture {
                        withAnimation(.easeIn){
                            selectedColor = color
                            print(color)
                        }
                    }
            }
            .frame(maxWidth:.infinity)
            .padding()
        }
    }
    
    
    
    
    private var clockSection : some View{
        ZStack{
            Circle()
                .frame(width: uiScreen().width * 0.9, height: uiScreen().width * 0.9, alignment: .center)
                .shadow(color: selectedColor, radius: 20, x: 0, y: 0)
            //드레그 할때 움직이는 아이
            Circle()
                .trim(from: startProgress, to: toProgress)
                .stroke(selectedColor, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                .frame(width: uiScreen().width * 0.8, height: uiScreen().width * 0.8, alignment: .center)
                .rotationEffect(Angle(degrees: -90))
            Circle()
                .frame(width: uiScreen().width * 0.7, height: uiScreen().width * 0.7, alignment: .center)
                .foregroundColor(Color.caltheme.black.opacity(0.85))
            ForEach(0..<60, id:\.self){i in
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: i % 5 == 0 ? 15 : 5, height:  1)
                    .offset(x: (uiScreen().width * 0.6) / 2)
                    .rotationEffect(.init(degrees: Double(i) * 6))
            }
            let texts = [6,9,12,3]
            ForEach(texts.indices, id: \.self){index in
                Text("\(texts[index])")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: Double(index) * -90))
                    .offset(y:(uiScreen().width * 0.25))
                    .rotationEffect(Angle(degrees: Double(index) * 90))
            }
            ForEach(1..<361, id: \.self){ sec in
                Rectangle()
                    .frame(width: 20, height: 1)
                    .foregroundColor(selectedColor)
                    .offset(x: (uiScreen().width * 0.8 ) / 2)
                    .rotationEffect(Angle(degrees: Double(sec)))
            }
            Rectangle()
                .frame(width: 130, height: 3)
                .foregroundColor(selectedColor)
                .offset(x: 60)
                .rotationEffect(Angle(degrees: Double(toAngle - 90 )))
            
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(selectedColor)
            
            Image(systemName: "alarm.fill")
                .font(.callout)
                .frame(width:30, height: 30)
                .foregroundColor(selectedColor)
                .rotationEffect(Angle(degrees: 90))
                .rotationEffect(Angle(degrees: -toAngle))
                .background(.white, in:Circle())
                .offset(x:  uiScreen().width * 0.8 / 2)
                .rotationEffect(Angle(degrees: toAngle))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            onDrag(value : value)
                        }
                )
                .rotationEffect(Angle(degrees: -90))
        }
    }
    private var timeTextSection: some View{
        HStack(spacing : 0) {
            Text(toProgress.roundCGFloat())
                .frame(width:50)
            Text("Minutes")
                .frame(width:130)
        }
        .font(.largeTitle.bold())
        .foregroundColor(Color.caltheme.secondaryText)
        .padding()
        .scaleEffect(1.5)
    }
    
    private var createButtonSection: some View{
        Button(action: {
            remindervm.addItem(selectedColor: selectedColor, reimderdtime: toProgress.roundCGFloat())
        }, label: {
            Text("Create Reminder")
        })
        .foregroundColor(Color.caltheme.secondaryText)
        .font(.headline)
        .frame(maxWidth: .infinity)
        .frame(height:50)
        .background(selectedColor)
        .cornerRadius(10)
        .padding()
    }
    
}
