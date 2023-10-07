//
//  Images.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/5.
//

import SwiftUI

struct Images: View {
    var body: some View {
        VStack {
            HStack {
                Image("girl")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 150)
                Image("girl")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 150)
                    .clipped()
            }
            Spacer().frame(height: 32)
            HStack {
                Image("girl")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 150)
                
                Image("girl")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
            }
            Spacer().frame(height: 8)
            HStack {
                Image("girl")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .cornerRadius(30)
                
                Image("girl")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
            }
            
            HStack {
                Image("girl")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(Circle())
                
                Image("girl")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    
            }
            
            HStack {
                Image("girl")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(Ellipse())
                /// image c has a clear background color
                Image("c")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                    .foregroundColor(Color.green)
            }
            
            
        }
        
    
    }
}

struct Images_Previews: PreviewProvider {
    static var previews: some View {
        Images()
    }
}
