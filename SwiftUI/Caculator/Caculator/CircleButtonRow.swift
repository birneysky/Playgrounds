//
//   CircleButtonRow.swift
//  Caculator
//
//  Created by birney on 2019/12/24.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct CircleButtonRow: View {
    var body: some View {
        HStack {
            CircleButton(title: "1")
            CircleButton(title: "2")
            CircleButton(title: "3")
            CircleButton(title: "4")

        }
    }
}

struct CircleButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonRow()
            CircleButtonRow().previewLayout(.fixed(width: 568, height: 320))
        }
    }
}
