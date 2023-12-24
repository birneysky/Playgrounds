//
//  ScrollView3.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/28.
//

import SwiftUI

struct ScrollView3: View {
    var body: some View {
        ScrollView {
            LazyVStack { /// 当数据量较大时，建议使用  Lazy Stack
                ForEach(0..<100) { _ in
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(0 ..< 15) { _ in
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .frame(width: 200, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ScrollView3_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView3()
    }
}
