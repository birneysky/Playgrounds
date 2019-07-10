//
//  ContentView.swift
//  Landmarks
//
//  Created by birneysky on 2019/7/8.
//  Copyright © 2019 Grocery. All rights reserved.
//

import SwiftUI

struct HikeView : View {
    @State private var showDetail = false
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Lonesome Ridge Trail")
                    Text("4.5 km")
                }
                Button(action: {
                    self.showDetail.toggle()
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                        .animation(.spring())
                }
            }
            if showDetail {
                HikeDetail()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        HikeView()
    }
}
#endif
