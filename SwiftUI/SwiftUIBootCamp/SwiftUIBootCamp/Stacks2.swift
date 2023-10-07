//
//  Stacks2.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/6.
//

import SwiftUI

struct Stacks2: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.orange)
                .frame(width: 350, height: 500)
            VStack(alignment: .leading, spacing: 30) {
                Rectangle()
                    .fill(.red)
                    .frame(width: 150, height: 150)
                Rectangle()
                    .fill(.green)
                    .frame(width: 100, height: 100)
                HStack(alignment: .bottom) {
                    Rectangle()
                        .fill(.purple)
                    .frame(width: 50, height: 50)
                    Rectangle()
                        .fill(.pink)
                        .frame(width: 75, height: 75)
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 25, height: 25)
                }
                .background(.white)
            }
            .background(.black)
        }
    }
}

struct Stacks2_Previews: PreviewProvider {
    static var previews: some View {
        Stacks2()
    }
}
