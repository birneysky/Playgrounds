//
//  ScrollView1.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/28.
//

import SwiftUI

struct ScrollView1: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<100) { _ in
                    Rectangle()
                        .frame(height: 300)
                }
            }
        }
    }
}

struct ScrollView1_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView1()
    }
}
