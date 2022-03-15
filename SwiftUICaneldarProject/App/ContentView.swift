//
//  ContentView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 14/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
