//
//  CreateReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import SwiftUI

struct CreateReminderView: View {
    @StateObject var remindervm = ReminderViewModel()
    
    @State var startAngle : Double = 0
    @State var toAngle : Double = 180
    
    @State var startProgress : CGFloat = 0
    @State var toProgress : CGFloat = 0.5
    
    
    @State private var createReminderText:String = ""

    var body: some View {
        VStack{
            inputTextTitle
            inputTextSection
            Divider()
//            reminderDetailsTitle
            ZStack{
                Circle()
                    .frame(width: uiScreen().width * 0.9, height: uiScreen().width * 0.9, alignment: .center)
                    .shadow(color: Color.caltheme.pink, radius: 20, x: 0, y: 0)
                
                //드레그 할때 움직이는 아이
                Circle()
                    .trim(from: startProgress, to: toProgress)
                    .stroke(Color.red.opacity(5), style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .frame(width: uiScreen().width * 0.8, height: uiScreen().width * 0.8, alignment: .center)
                    .rotationEffect(Angle(degrees: -90))
               
                Circle()
                    .frame(width: uiScreen().width * 0.7, height: uiScreen().width * 0.7, alignment: .center)
                    .foregroundColor(Color.caltheme.black.opacity(0.85))
                ForEach(1..<361, id: \.self){ sec in
                    Rectangle()
                            .frame(width: 20, height: 1)
                            .foregroundColor(Color.pink)
                            .offset(x: (uiScreen().width * 0.8 ) / 2)
                            .rotationEffect(Angle(degrees: Double(sec)))
                }
                Rectangle()
                        .frame(width: 130, height: 3)
                        .foregroundColor(Color.caltheme.red)
                        .offset(x: 60)
                        .rotationEffect(Angle(degrees: Double(-90)))
                        
                Circle()
                    .frame(width: 15, height: 15, alignment: .center)
                    .foregroundColor(Color.caltheme.red)
                
                Image(systemName: "pawprint.fill")
                    .font(.callout)
                    .frame(width:30, height: 30)
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 90))
                    .rotationEffect(Angle(degrees: toAngle))
                    .background(.white, in:Circle())
                    .offset(x:  uiScreen().width * 0.8 / 2)
                    .rotationEffect(Angle(degrees: -90))
                    .rotationEffect(Angle(degrees: toAngle))
            }
         

            Text("00:00")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.caltheme.secondaryText)
                .padding()
            
            Button(action: {
                
            }, label: {
                Text("Create Reminder")
            })
            .foregroundColor(Color.caltheme.secondaryText)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height:50)
            .background(Color.caltheme.red)
            .cornerRadius(10)
            .padding()
            
            
        }
    }
    func uiScreen() -> CGRect{
        return UIScreen.main.bounds
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
            .padding(.vertical)
    }

    private var inputTextSection : some View{
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.caltheme.secondaryText)
            TextField("할일을 입력해주세요", text: $createReminderText)
                .foregroundColor(
                    createReminderText.isEmpty ?
                    Color.caltheme.secondaryText : Color.caltheme.violet)
                .disableAutocorrection(true)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.caltheme.violet)
                    .opacity(createReminderText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.closeKeyboard()
                        createReminderText = ""
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
        .padding()
        
    }
    
    private var reminderDetailsTitle :some View{
        Text("Reminder Timer")
            .font(.headline)
            .bold()
            .foregroundColor(Color.caltheme.secondaryText)
            .frame(maxWidth:.infinity, alignment: .center)
            .padding(.vertical)
    }
}
