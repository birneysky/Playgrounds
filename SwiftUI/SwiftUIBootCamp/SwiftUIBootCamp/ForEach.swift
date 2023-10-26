//
//  ForEach.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/26.
//

import SwiftUI

struct ForEachA: View {
    var body: some View {
        VStack {
            ForEach(0..<10) { index in
                HStack {
                    Circle()
                        .frame(width: 30, height: 30)
                    Text("Hello world: \(index)")
                }
                
            }
        }
    }
}

struct ForEach_Previews: PreviewProvider {
    static var previews: some View {
        ForEachA()
    }
}
