//
//  Gradients.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/2.
//

import SwiftUI

struct Gradients: View {
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(height: 200)
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
                    .frame(height: 200)
            }
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.orange, Color.purple]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .frame(height: 200)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                       center: .center,
                                       startRadius: 5,
                                       endRadius: 200)
                    )
                    .frame(height: 200)
            }
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                       center: .topLeading,
                                       startRadius: 5,
                                       endRadius: 150)
                    )
                    .frame(height: 200)
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                       center: .center,
                                       startRadius: 5,
                                       endRadius: 150)
                    )
                    .frame(height: 200)
            }
            
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center, angle: .degrees(0))
                    )
                    .frame(height: 200)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center, angle: .degrees(180))
                    )
                    .frame(height: 200)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .topLeading, angle: .degrees(180))
                    )
                    .frame(height: 200)
            }
            
        }
    }
}

struct Gradients_Previews: PreviewProvider {
    static var previews: some View {
        Gradients()
    }
}
