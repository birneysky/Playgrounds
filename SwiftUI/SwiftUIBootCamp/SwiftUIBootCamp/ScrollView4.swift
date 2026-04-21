//
//  ScrollView4.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2025/1/27.
//

import SwiftUI

import SwiftUI

struct ScrollView4: View {
    let items = [
        "SwiftUI is a modern way to declare user  interfaces for any Apple platform.",
        "Create beautiful, dynamic apps faster than ever before.",
        "SwiftUI helps you build great-looking apps across all Apple platforms with the power of Swift — and as little code as possible.",
        "hah","我知道你喔豆没有错","48302914",
        "hahhaha"
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50),spacing: 8, alignment: .leading)], spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(8)
                        .fixedSize()
                }
            }
            .padding()
        }
    }
}

struct ScrollView4_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView4()
    }
}
