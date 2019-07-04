//
//  Shapes.swift
//  SwfitUI
//
//  Created by birney on 2019/7/4.
//  Copyright © 2019 COOL. All rights reserved.
//

import SwiftUI

struct Hexagon : View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: xOffset + width * 0.95,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                HexagonParameters.points.forEach {
                    path.addLine(
                        to: .init(
                            x: xOffset + width * $0.useWidth.0 * $0.xFactors.0,
                            y: height * $0.useHeight.0 * $0.yFactors.0
                        )
                    )
                    
                    path.addQuadCurve(
                        to: .init(
                            x: xOffset + width * $0.useWidth.1 * $0.xFactors.1,
                            y: height * $0.useHeight.1 * $0.yFactors.1
                        ),
                        control: .init(
                            x: xOffset + width * $0.useWidth.2 * $0.xFactors.2,
                            y: height * $0.useHeight.2 * $0.yFactors.2
                        )
                    )
                }
                }
                .fill(LinearGradient(
                    gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 0.6)
                    )
                )
                .aspectRatio(1, contentMode: .fit)
        }
    }
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct Triangle : View {
    var body: some View {
        GeometryReader { geometry in
            //let scale: CGFloat = min(geometry.size.width, geometry.size.height)
            Path { path in
                path.move(to: .init(x: 0.5, y: 0))
                path.addLine(to: .init(x: 0, y: 0.5))
                path.addLine(to: .init(x: 1, y: 0.5))
                path.addLine(to: .init(x: 0.5, y: 0))
            }
            .applying(.init(scaleX: geometry.size.width, y: geometry.size.width))
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
            .aspectRatio(1, contentMode: .fit)
        }
    }
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct Square: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: .init(x: 0.5, y: 0))
                path.addLine(to: .init(x: 0, y: 0.5))
                path.addLine(to: .init(x: 0.5, y: 1))
                path.addLine(to: .init(x: 1, y:0.5))
                path.addLine(to: .init(x: 0.5, y:0))
                }
                .applying(.init(scaleX: geometry.size.width, y: geometry.size.width))
                .fill(LinearGradient(
                    gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 0.6)
                    )
                )
                .aspectRatio(1, contentMode: .fit)
        }
    }
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

#if DEBUG
struct Shapes_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            Hexagon()
            Triangle()
            Square()
        }
        .previewLayout(.fixed(width: 300, height: 300))
    }
}
#endif
