//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// Present the view controller in the Live View window
let pvc = PlayViewController()
let nav = UINavigationController(rootViewController: pvc)
nav.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
PlaygroundPage.current.liveView = nav.view
