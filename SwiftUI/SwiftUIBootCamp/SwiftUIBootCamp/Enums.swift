//
//  Enums.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/26.
//

import SwiftUI

struct Enums: View {
    let backgroundColor: Color
    let count: Int
    let title: String
   
    enum Friut {
        case apple
        case orange
    }
    
    init(count: Int, friut: Friut) {
        self.count = count
        if friut == .apple {
            title = "Apples"
            backgroundColor = .red
        } else  {
            title = "Oranges"
            backgroundColor = .orange
        }
    }
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

struct Enums_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Enums(count: 3, friut: .apple)
            Enums(count: 300, friut: .orange)
            Enums(count: 52, friut: .apple)
        }
       
    }
}
