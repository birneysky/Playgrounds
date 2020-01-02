//
//  ContentView.swift
//  Examples
//
//  Created by birneysky on 2019/12/30.
//  Copyright © 2019 Grocery. All rights reserved.
//

import SwiftUI




struct ContentView: View {
    var body: some View {
        HStack {
            Button("hello") {

            }.buttonStyle(BtnContentStyple(title: "flame",
                                           systemImageName: "flame.fill",
                                           titleColor: .red))
            Button(action:{
            }) {
                ButtonContentView(title: "flame",
                                  systemImageName: "flame.fill",
                                  titleColor: .red)
            }
            Button(action: {

            }){
                ButtonContentView(title: "square",
                                  systemImageName: "square.and.arrow.up.fill",
                                  titleColor: .green)
            }

            Button(action: {

            }){
                ButtonContentView(title: "trash",
                                  systemImageName: "trash.fill",
                                  titleColor: .blue)
            }
            Button(action: {

            }){
                ButtonContentView(title: "send",
                                  systemImageName: "paperplane.fill",
                                  titleColor: .orange)
            }

            Button(action: {

            }){
                ButtonContentView(title: "video",
                                  systemImageName: "video.fill",
                                  titleColor: .pink)
            }
            Button(action: {

            }){
                ButtonContentView(title: "audio",
                systemImageName: "mic.fill",
                    titleColor: .purple)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            //Button(ButtonStyleConfiguration())
        }
    }
}
