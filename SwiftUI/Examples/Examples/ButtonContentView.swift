//
//  ButtonView.swift
//  Examples
//
//  Created by birneysky on 2019/12/31.
//  Copyright © 2019 Grocery. All rights reserved.
//

import SwiftUI

struct BtnContentStyple: ButtonStyle {
    let title: String
    let systemImageName: String
    let titleColor: Color
    func makeBody(configuration: Self.Configuration) -> ButtonContentView {
        ButtonContentView(title: title, systemImageName: systemImageName, titleColor: configuration.isPressed ? .black : titleColor)
    }
    
    typealias Body = ButtonContentView
    
    
}

struct ButtonContentView: View {
    let title: String
    let systemImageName: String
    let titleColor: Color
    var body: some View {
        VStack{
        Image(systemName: systemImageName)
            .imageScale(.large)
            .foregroundColor(titleColor)
            Text(title)
                .foregroundColor(titleColor)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonContentView(title: "flame", systemImageName: "flame.fill", titleColor: .red)
            
        }
    }
}
