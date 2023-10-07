//
//  Colors.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/9/28.
//

import SwiftUI

struct Colors: View {
    var body: some View {
        VStack {
            HStack  {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.red)
    
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.primary)
            }
            
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        Color(#colorLiteral(red:0, green:0.32, blue:0.5, alpha: 1))
                    )
                    .frame(width: 250, height: 150)
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        Color(UIColor.secondarySystemBackground)
                    )
                    .frame(width: 150, height: 150)
                    .shadow(radius: 10)
            }
            
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    Color("CustomColor")
                )
                .frame(width: 300, height: 200)
                .shadow(color: .red.opacity(0.2), radius: 20, x: 0, y: 20)
        }
    }
}

struct Colors_Previews: PreviewProvider {
    static var previews: some View {
        Colors()
    }
}
