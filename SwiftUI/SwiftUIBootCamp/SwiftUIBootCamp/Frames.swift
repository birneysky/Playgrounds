//
//  Frames.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/5.
//

import SwiftUI

/// 添加任何一种元素，无论是文本、图片、还是形状到屏幕上。
/// 它都有一个 frame。
/// 当点击这个文本时，可以在预览视图中看到 frame，就是下面突出显示的那条蓝色线，
/// 它勾勒出这个 frame 的位置
struct Frames: View {
    var body: some View {
        VStack {
            /// 对齐方式会明显地调整 Frame 内的内容, 所以这个 Frame 是红色的。
            /// 但是 Frame 里的内容是文本和它上面的背景， Frame 之前的东西是 Frame 中的内容
            /// 所以 “hello world" 和 绿色背景都对齐到中心位置
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(.green)
                .frame(width: 300, height: 100)
                .background(.red)
            ///但是我们可以改变这个对齐方式，如果想让它对齐到左上角， 这里使用 topLeading 就好了
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(.green)
                .frame(width: 300, height: 100, alignment: .topLeading)
                .background(.red)
            Text("the alignment is going to obviously align the content within the frame. so right now this frame is red. but the content in the frame is the text and this background above it so the stuff  before the frame  is the content that's inside the frame . so right now the hello world and the background green are aligning to the center and we can see that in the preview . but we can change this alignment if we want to align it to left side we could do top leading and this is really important as you start making more dynamic and complex views")
                .background(.green)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(.red)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(.red)
                .frame(height: 100, alignment: .top)
                .background(.orange)
                .frame(width: 150)
                .background(.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.pink)
                .frame(height: 200)
                .background(.green)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .background(.yellow)
        }
    }
}

struct Frames_Previews: PreviewProvider {
    static var previews: some View {
        Frames()
    }
}
