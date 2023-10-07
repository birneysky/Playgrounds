//
//  Stack3.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/6.
//

import SwiftUI

struct Stack3: View {
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20) {
                Text("5")
                    .font(.largeTitle)
                    .underline()
                Text("Items in your cart:")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            VStack(spacing: 50) {
                ZStack {
                    Circle()
                        .fill(.green)
                        .frame(width: 100, height: 100)
                    Text("1")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Text("1")
                    .font(.title)
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(.green)
                            .frame(width: 100, height: 100)
                    )
            }
        }
        
    }
}

struct Stack3_Previews: PreviewProvider {
    static var previews: some View {
        Stack3()
    }
}
