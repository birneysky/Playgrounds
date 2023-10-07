//
//  BackgroundAndOverlay.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/6.
//

import SwiftUI

struct BackgroundAndOverlay: View {
    var body: some View {
        VStack {
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .background(.red)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]),
                                             startPoint: .leading,
                                               endPoint: .trailing))
            }
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .background(
                        Circle()
                            .fill(.green)
                    )
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .frame(width: 100, height: 100)
                    .background(
                        Circle()
                            .fill(.green)
                    )
            }
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .frame(width: 100, height: 100, alignment: .center)
                    .background(
                        Circle()
                            .fill(.blue)
                    )
                    .background(
                        Circle()
                            .fill(.red)
                    )
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .frame(width: 100, height: 100, alignment: .center)
                    .background(
                        Circle()
                            .fill(.blue)
                    )
                    .frame(width: 120, height: 120, alignment: .center)
                    .background(
                        Circle()
                            .fill(.red)
                    )
            }
            Spacer().frame(height: 60)
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .background(
                        Circle()
                            .fill(.blue)
                            .frame(width: 100, height: 100, alignment: .center)
                    )
                    .background(
                        Circle()
                            .fill(.red)
                            .frame(width: 120, height: 120, alignment: .center)
                    )
                Spacer().frame(width: 30)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .background(
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]),
                                                 startPoint: .leading,
                                                   endPoint: .trailing))
                            .frame(width: 100, height: 100, alignment: .center)
                    )
                    .background(
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .red]),
                                                 startPoint: .leading,
                                                   endPoint: .trailing))
                            .frame(width: 120, height: 120, alignment: .center)
                    )
            }
            Spacer().frame(height: 60)
            HStack {
                Circle()
                    .fill(.pink)
                    .frame(width: 100, height: 100)
                    .overlay (
                        Text("1")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    )
                    
                Circle()
                    .fill(.pink)
                    .frame(width: 100, height: 100)
                    .overlay (
                        Text("1")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    )
                    .background(
                        Circle()
                            .fill(.purple)
                            .frame(width: 110, height: 110)
                    )
            }
            
            Spacer().frame(height: 60)
            HStack {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .overlay (
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 50, height: 50)
                        ,alignment: .bottomTrailing
                    )
                    .background(
                        Rectangle()
                            .fill(.red)
                            .frame(width: 150, height: 150)
                    )
                Spacer().frame(width: 100)
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .frame(width: 100, height: 100)
                            .shadow(color: .black, radius: 10, x: 0, y: 10)
                            .overlay(
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 35, height: 25)
                                    .overlay(
                                        Text("5")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    )
                                ,alignment: .bottomTrailing
                            )
                    )
                
            }
        }
        
    }
}

struct BackgroundAndOverlay_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAndOverlay()
    }
}
