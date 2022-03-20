//
//  CreateReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import SwiftUI

struct CreateReminderView: View {
    @StateObject var remindervm = ReminderViewModel()
 
    @State private var isshowAlert : Bool = false
    @State private var textalert : String = ""
    
    @Environment(\.presentationMode) var presentationMode
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
        .alert(isPresented: $isshowAlert, content: getAlert)
    }
    func onDrag(value: DragGesture.Value){
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        var angle = radians * 180 / .pi
        if angle < 0 {angle += 360}
        let progress = angle / 360
        remindervm.toAngle = angle
        remindervm.toProgress = progress
    }
    func isPressedCreateReminer() {
        if textCondition(){
            presentationMode.wrappedValue.dismiss()
        }
    }
    func textCondition() -> Bool {
        if remindervm.createReminderText.count < 2{
            textalert = "Please, insert at least 3 characters\n😅😅😅"
            isshowAlert = true
            return false
        } else {
            return true
        }
    }
    func getAlert() -> Alert{
        Alert(title: Text(textalert))
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
                .foregroundColor(remindervm.selectedColor)
            TextField("할일을 입력해주세요", text: $remindervm.createReminderText)
                .foregroundColor(
                    remindervm.createReminderText.isEmpty ?
                    Color.caltheme.secondaryText : remindervm.selectedColor)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(remindervm.selectedColor)
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
                            .foregroundColor(color == remindervm.selectedColor ? Color.white : Color.clear)
                            .shadow(color: color == remindervm.selectedColor ? Color.white : Color.clear, radius: 5, x: 0, y: 0))
                    .onTapGesture {
                        withAnimation(.easeIn){
                            remindervm.selectedColor = color
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
                .frame(width: remindervm.uiScreen().width * 0.9, height: remindervm.uiScreen().width * 0.9, alignment: .center)
                .shadow(color: remindervm.selectedColor, radius: 20, x: 0, y: 0)
            //드레그 할때 움직이는 아이
            Circle()
                .trim(from: remindervm.startProgress, to: remindervm.toProgress)
                .stroke(remindervm.selectedColor, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
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
                    .foregroundColor(remindervm.selectedColor)
                    .offset(x: (remindervm.uiScreen().width * 0.8 ) / 2)
                    .rotationEffect(Angle(degrees: Double(sec)))
            }
            
            Rectangle()
                .frame(width: 130, height: 3)
                .foregroundColor(remindervm.selectedColor)
                .offset(x: 60)
                .rotationEffect(Angle(degrees: Double(remindervm.toAngle - 90 )))
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(remindervm.selectedColor)
            Image(systemName: "alarm.fill")
                .font(.callout)
                .frame(width:30, height: 30)
//                .foregroundColor(selectedColor)
                .rotationEffect(Angle(degrees: 90))
                .rotationEffect(Angle(degrees: -remindervm.toAngle))
                .background(.white, in:Circle())
                .offset(x:remindervm.uiScreen().width * 0.8 / 2)
                .rotationEffect(Angle(degrees: remindervm.toAngle))
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
            Text(remindervm.toProgress.roundCGFloat())
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
            isPressedCreateReminer()
            remindervm.addItem(title: remindervm.createReminderText, selectedColor: remindervm.selectedColor, remindedtime: remindervm.toProgress)
            
            
//            LoadedReminderView(toProgress : remindervm.toProgress, selectedColor: remindervm.selectedColor)
        }, label: {
            Text("Create Reminder")
        })
        .foregroundColor(Color.caltheme.secondaryText)
        .font(.headline)
        .frame(maxWidth: .infinity)
        .frame(height:50)
        .background(remindervm.selectedColor)
        .cornerRadius(10)
        .padding()
    }
}
