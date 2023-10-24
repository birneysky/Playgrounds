//
//  Spacer2.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/24.
//

import SwiftUI

struct Spacer2: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "xmark")
                Spacer()
                Image(systemName: "gear")
            }
            .font(.title)
            .padding()
            Spacer()
                //.frame(width: 10)
                .background(.red)
            Rectangle()
                .frame(height: 50)
        }
    }
}

struct Spacer2_Previews: PreviewProvider {
    static var previews: some View {
        Spacer2()
    }
}
