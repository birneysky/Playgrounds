//
//  Spacer.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/24.
//

import SwiftUI

/// spaces do have a default minimum length  (8 or 10)
struct SpacerA: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(width: 100, height: 100)
                Spacer()
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            }
            .background(.purple)
            
            HStack {
                Rectangle()
                    .frame(width: 100, height: 100)
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            }
            .background(.purple)
            
            HStack {
                Spacer()
                    .frame(height: 10)
                    .background(.orange)    
                Rectangle()
                    .frame(width: 100, height: 100)
                
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            }
            .background(.purple)
            
            HStack(spacing: 0) {
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .frame(width: 50, height: 50)
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
            }
            
            HStack(spacing: 0) {
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .frame(width: 50, height: 50)
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
            }.padding(.horizontal, 150)
            
            
            
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .frame(width: 50, height: 50)
                Spacer(minLength: 4)
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
                Spacer(minLength: 16)
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                Spacer(minLength: 0)
                    .frame(height: 10)
                    .background(.orange)
            }.padding(.horizontal, 150)
            
            
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .frame(width: 50, height: 50)
                Spacer(minLength: 4)
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
                Spacer(minLength: 16)
                    .frame(height: 10)
                    .background(.orange)
                Rectangle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                Spacer(minLength: 0)
                    .frame(height: 10)
                    .background(.orange)
            }
        }
        
        
        
        
    }
}

struct Spacer_Previews: PreviewProvider {
    static var previews: some View {
        SpacerA()
    }
}
