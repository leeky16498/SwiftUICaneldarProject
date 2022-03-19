//
//  TaskRowView.swift
//  SwiftUICaneldarProject
//
//  Created by Kyungyun Lee on 19/03/2022.
//

import SwiftUI

struct TaskRowView: View {
    
    let task : Task
    
    var body: some View {
        HStack {
            VStack(alignment : .leading) {
                Text(task.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                Text("\(task.scheduledTime)")
                    .font(.headline)
                
                Text("언제까지 뭐하고 뭐하기, 그래서 이거 완전히 마치고 그 다음에 이거하기")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .italic()
                    .padding(.top, 3)
                    .lineLimit(2)
            }
            .padding(.leading, 25)
            
            Spacer()
        
            NavigationLink(destination: {
                CreateReminderView()
            }, label: {
                Label("Timer", systemImage: "clock")
                    .frame(width: 110, height : 40)
                    .background(.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(12)
            })
            .padding(.trailing, 40)
            .padding(.leading, 10)
        }
        .frame(maxWidth : .infinity)
        .frame(height : 120)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.caltheme.green)
                .frame(width : 12)
            ,alignment: .leading
        )
        .cornerRadius(10)
        .offset(x: 20)
        .padding(.vertical, 3)
    }
}

//struct TaskRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRowView()
//            .previewLayout(.sizeThatFits)
//            .preferredColorScheme(.dark)
//    }
//}
