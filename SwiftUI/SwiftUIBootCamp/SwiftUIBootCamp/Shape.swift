//
//  Shape.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/9/28.
//

import SwiftUI

struct Shape: View {
    var body: some View {
        VStack {
            HStack  {
                Ellipse()
                    .frame(width: 200, height: 100)
                Ellipse()
                    .fill(Color.purple)
                    .frame(width: 200, height: 100)
            }
            HStack {
                Ellipse()
                    .stroke(Color.green, lineWidth: 20)
                    .frame(width: 200, height: 100)
                Capsule()
                    .frame(width: 200, height: 100)
            }
            
            HStack {
                Capsule(style: .continuous)
                    .frame(width: 200, height: 100)
                Capsule(style: .circular)
                    .stroke(Color.green, lineWidth: 20)
                    .frame(width: 200, height: 100)
            }
            
            HStack {
                Rectangle()
                    .frame(width: 200, height: 100)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.orange)
                    .frame(width: 200, height: 100)
            }
            
        }
    }
}

struct Shape_Previews: PreviewProvider {
    static var previews: some View {
        Shape()
    }
}
