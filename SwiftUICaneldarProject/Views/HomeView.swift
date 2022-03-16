//
//  HomeView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 15/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State var currentDate : Date = Date()
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                CalendarView(currentDate: $currentDate)
                    .padding()
            }
            .navigationTitle("Planery 🥰")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
