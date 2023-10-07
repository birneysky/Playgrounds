//
//  Stacks.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/6.
//

import SwiftUI

struct Stacks: View {
    var body: some View {
        
        VStack {
            HStack() {
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(.green)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(.orange)
                    .frame(width: 100, height: 100)
            }
            
            HStack(alignment: .bottom) {
                Rectangle()
                    .fill(.red)
                    .frame(width: 150, height: 150)
                Rectangle()
                    .fill(.green)
                    .frame(width: 125, height: 125)
                Rectangle()
                    .fill(.orange)
                    .frame(width: 100, height: 100)
            }
            
            HStack(alignment: .top, spacing: 20) {
                Rectangle()
                    .fill(.red)
                    .frame(width: 150, height: 150)
                Rectangle()
                    .fill(.green)
                    .frame(width: 125, height: 125)
                Rectangle()
                    .fill(.orange)
                    .frame(width: 100, height: 100)
            }
            HStack {
                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 150, height: 150)
                    Rectangle()
                        .fill(.green)
                        .frame(width: 125, height: 125)
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 100, height: 100)
                }
                VStack(alignment: .trailing) {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 150, height: 150)
                    Rectangle()
                        .fill(.green)
                        .frame(width: 125, height: 125)
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 100, height: 100)
                }
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 150, height: 350)
                    Rectangle()
                        .fill(.green)
                        .frame(width: 125, height: 250)
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 100, height: 150)
                }
            }
            
        }
    }
}

struct Stacks_Previews: PreviewProvider {
    static var previews: some View {
        Stacks()
    }
}
