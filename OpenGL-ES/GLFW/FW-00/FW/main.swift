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
