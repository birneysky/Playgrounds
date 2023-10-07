//
//  Icons.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/5.
//

import SwiftUI

struct Icons: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .frame(width: 300, height: 200)
            }
            
            HStack {
                Image(systemName: "heart.fill")
                    .font(.system(size: 100))
                    .foregroundColor(Color.pink)
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 200, height: 100)
            }

            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color.green)
                    .frame(width: 200, height: 100)
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.green)
                    .frame(width: 150, height: 150)
            }
            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(Color.green)
                    .frame(width: 150, height: 150)
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.green)
                    .frame(width: 150, height: 150)
            }
            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(Color.green)
                    .frame(width: 150, height: 150)
                    .clipped()
                /// MutilColor icons
                Image(systemName: "testtube.2")
                    .renderingMode(.original)
                    .font(.system(size: 100))
            }
            
        }
        
    }
}

struct Icons_Previews: PreviewProvider {
    static var previews: some View {
        Icons()
    }
}
