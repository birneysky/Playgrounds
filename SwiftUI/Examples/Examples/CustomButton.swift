//
//  CustomButton.swift
//  Examples
//
//  Created by birneysky on 2020/3/17.
//  Copyright © 2020 Grocery. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    var body: some View {
        Button(action:{
            
        }){
            Text("This is a Button")
            Image(systemName: "person.crop.circle.fill")
                .aspectRatio(contentMode: .fit)
                .frame(width:40, height: 40)
        }.padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(.infinity)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
