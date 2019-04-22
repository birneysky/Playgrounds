import UIKit
import CoreImage
import PlaygroundSupport

var str = "Hello, playground"

let filterNames = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
let lvc = FilterListViewController(style: .plain)
let rootNav = UINavigationController(rootViewController: lvc)
rootNav.view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 320, height: 640))
PlaygroundPage.current.liveView = rootNav.view

//let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
//
//imageView.contentMode = .scaleAspectFit
//
//PlaygroundPage.current.liveView = imageView
//
//let path = Bundle.main.path(forResource: "img_001", ofType: "png")
//let url = URL(fileURLWithPath: path!);
//let img2 = CIImage(contentsOf: url)
//let bbimg = blur(radius: 0.5)(img2!)
//imageView.image = UIImage(ciImage: bbimg)
//print(bbimg)
//
//let bbimg2 = blur(radius: 5.0)(img2!)
//print(bbimg2)
//imageView.image = UIImage(ciImage: bbimg2)
