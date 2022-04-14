//
//  test.swift
//  SwiftUICaneldarProject
//
//  Created by Chuljin Hwang on 2022/04/14.
//

import SwiftUI

struct test: View {
  @State var task : TaskModel
    var body: some View {
      Text(task.title)
    }
}

//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        test()
//    }
//}
