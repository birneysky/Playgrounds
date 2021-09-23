//
//  CardView.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool =  true 
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke()
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
            
        }
        .onTapGesture {
        isFaceUp = !isFaceUp
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(content: "🚕")
            .preferredColorScheme(.dark)
        CardView(content: "✈️")
            .preferredColorScheme(.light)
    }
}
