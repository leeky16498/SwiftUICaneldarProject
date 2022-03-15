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
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.caltheme.secondaryText)
            TextField("Search by name or symblo...", text: $createReminderText)
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
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.caltheme.background)
                .shadow(color: Color.caltheme.black.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct CreateReminderView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReminderView()
    }
}
