//
//  ContentView.swift
//  SwfitUI
//
//  Created by birney on 2019/6/18.
//  Copyright © 2019 COOL. All rights reserved.
//

import SwiftUI

struct LandmarkDetailView : View {
    var body: some View {
        VStack {
            MapView()
                .frame(height:300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -160)
            
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                    .color(.black)
                HStack {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

#if DEBUG
struct LandmarkDetailView_Previews : PreviewProvider {
    static var previews: some View {
        LandmarkDetailView()
    }
}
#endif
