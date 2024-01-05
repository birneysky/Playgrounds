//
//  main.swift
//  FW
//
//  Created by Bruce on 2024/1/2.
//

import Foundation
import OpenGL

var person = Person("a", 2)
if glfwInit() == 0 {
    fatalError()
}
let window = glfwCreateWindow(600, 400, "Boing (classic Amiga demo)", nil, nil)
guard window != nil else {
    fatalError()
}


if let version = glGetString(GLenum(GL_VERSION)) {
    NSLog("\(version)")
} else {
    NSLog("OpenGL was deprecated")
}

glfwMakeContextCurrent(window)

/// 创建并且绑定缓冲区
var buffer: GLuint = 0
glGenBuffers(1, &buffer)
/// 这里的绑定意味着，将要对这个 buffer 进行操作， 你可能注意到这里并没指定缓冲区有多大
glBindBuffer(GLenum(GL_ARRAY_BUFFER), buffer)
/// 指定数据
///  有两种方法可以做到这一点
///  1.不要直接提供数据，在创建缓冲区时，指定实际大小，然后直接给出数据或者什么都不给他，合适的时机更新它
///  2. 直接提供数据



while (glfwWindowShouldClose(window) == 0) {
    
    glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    
    glBegin(GLenum(GL_TRIANGLES))
    glVertex2f(-0.5, -0.5)
    glVertex2f(0, 0.5)
    glVertex2f(0.5, -0.5)
    glEnd()
    
    glfwSwapBuffers(window);
    glfwPollEvents();
}

glfwTerminate();
