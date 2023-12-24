//
//  Foreach2.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/27.
//

import SwiftUI

struct Foreach2: View {
    
    let data = ["Hi", "Hello", "Hey every"]
    var body: some View {
        VStack {
            ForEach(data.indices) { index in
                Text("\(data[index]): \(index)")
            }
        }
    }
}

struct Foreach2_Previews: PreviewProvider {
    static var previews: some View {
        Foreach2()
    }
}
