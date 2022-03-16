//
//  CreateReminderView.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/03/15.
//

import SwiftUI

struct CreateReminderView: View {
    
    @State private var createReminderText:String = ""
    
    var body: some View {
        VStack{
            inputTextTitle
            inputTextSection
            Divider()
            reminderDetailsTitle
        }
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
        .padding(.vertical,20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.caltheme.background)
                .shadow(color: Color.caltheme.black.opacity(0.5), radius: 10, x: 0, y: 0)
        )
        .padding()
        
    }
    
    private var reminderDetailsTitle :some View{
        Text("Reminder Details")
            .font(.headline)
            .bold()
            .foregroundColor(Color.caltheme.secondaryText)
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(.vertical)
    }
}
