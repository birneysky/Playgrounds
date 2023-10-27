//
//  ScrollView3.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/28.
//

import SwiftUI

struct ScrollView2: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(0..<100) { _ in
                    Rectangle()
                        .fill(.pink)
                        .frame(height: 300)
                }
            }
        }
    }
}

struct ScrollView3_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView2()
    }
}
