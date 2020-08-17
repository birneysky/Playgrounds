//
//  TestView.swift
//  Examples
//
//  Created by birneysky on 2020/1/4.
//  Copyright © 2020 Grocery. All rights reserved.
//

import SwiftUI

class GlobalEnviroment: ObservableObject {
    @Published var display = ""
}

enum CaculatorButtonItem: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent
    case decimal
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .ac: return "AC"
        case .plusMinus: return "±"
        case .percent: return "%"
        case .decimal: return "."
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return Color(.orange)
        }
    }
}

struct CaculatorPanel: View {
    @EnvironmentObject var env: GlobalEnviroment;
    
    let buttonTitles: [[CaculatorButtonItem]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack (spacing: 12){
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttonTitles, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.env.display = item.title
                            }) {
                                Text(item.title)
                                    .font(.system(size: 32))
                                    .frame(width:self.buttonItemWidth(for: item), height:self.buttonItemHeight)
                                    .foregroundColor(.white)
                                    .background(item.backgroundColor)
                                    .cornerRadius(self.buttonItemHeight / 2)
                            }
                        }
                    }
                }
                
            }.padding(.bottom)
        }
    }
    
    func buttonItemWidth(for item: CaculatorButtonItem) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5  * 12) / 4
    }
    
    var buttonItemHeight: CGFloat {
        (UIScreen.main.bounds.width - 5  * 12) / 4
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        CaculatorPanel().environmentObject(GlobalEnviroment())
    }
}
