//
//  Bage.swift
//  SwfitUI
//
//  Created by birneysky on 2019/7/2.
//  Copyright © 2019 COOL. All rights reserved.
//

import SwiftUI

struct Bage : View {
    var body: some View {
        Path { path in
            let width: CGFloat = 100.0
            let height = width
            path.move(to: CGPoint(x: width * 0.95, y: height * 0.20))
        }
        .fill(Color.black)
    }
}

#if DEBUG
struct Bage_Previews : PreviewProvider {
    static var previews: some View {
        Bage()
    }
}
#endif
