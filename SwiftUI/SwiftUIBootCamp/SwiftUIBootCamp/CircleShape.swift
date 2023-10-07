//
//  Shape.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/9/28.
//

import SwiftUI

struct CircleShape: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(.green)
                Circle()
                    .foregroundColor(.pink)
            }
            HStack {
                Circle()
                    .stroke()
                Circle()
                    .stroke(Color.blue)
            }
            HStack {
                Circle()
                    .stroke(Color.orange, lineWidth: 10)
                Circle()
                    .stroke(Color.cyan,
                            style: StrokeStyle(lineWidth: 15, lineCap: .butt, dash: [10]))
            }
            HStack{
                Circle()
                .stroke(Color.cyan,
                        style: StrokeStyle(lineWidth: 15, lineCap: .round, dash: [30]))
                Circle()
                .stroke(Color.cyan,
                        style: StrokeStyle(lineWidth: 15, lineCap: .square, dash: [19]))
            }
            HStack {
                Circle()
                    .trim(from: 0.1, to: 1.0)
                Circle()
                    .trim(from: 0.3, to: 1.0)
            }
            HStack {
                Circle()
                    .trim(from: 0.3, to: 1.0)
                    .stroke(Color.purple, lineWidth: 20)
            }
        }

    }
}

struct Circle_Shape_Previews: PreviewProvider {
    static var previews: some View {
        CircleShape()
    }
}
