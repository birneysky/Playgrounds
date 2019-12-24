//
//  Panel.swift
//  Caculator
//
//  Created by birney on 2019/12/24.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct Panel: View {
    var body: some View {
        VStack {
            CircleButtonRow()
            CircleButtonRow()
            CircleButtonRow()
            CircleButtonRow()
            CircleButtonRow()
            CircleButtonRow()
            CircleButtonRow()

        }
    }
}

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Panel()
            Panel().previewLayout(.fixed(width: 568, height: 320))
        }
    }
}
