//
//  ContentView.swift
//  Landmarks
//
//  Created by birneysky on 2019/7/8.
//  Copyright © 2019 Grocery. All rights reserved.
//

import SwiftUI

struct HikeView : View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Lonesome Ridge Trail")
                    Text("4.5 km")
                }
                Button(action: {
                    
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(90))
                        .scaleEffect(1.5)
                        .padding()
                        .animation(.basic())
                }
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
