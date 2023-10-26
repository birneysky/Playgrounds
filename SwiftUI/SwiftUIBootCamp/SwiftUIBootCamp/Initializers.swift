//
//  Initializers.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/25.
//

import SwiftUI

struct Initializers: View {
    let backgroundColor: Color
    let count: Int
    let title: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(count)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

struct Initializers_Previews: PreviewProvider {
    static var previews: some View {
        Initializers(backgroundColor: .purple, count: 30, title: "Apples")
    }
}
