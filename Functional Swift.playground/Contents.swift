import UIKit
import PlaygroundSupport

var str = "Hello, playground"


let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))

imageView.contentMode = .scaleAspectFit

PlaygroundPage.current.liveView = imageView

let path = Bundle.main.path(forResource: "img_001", ofType: "png")
let url = URL(fileURLWithPath: path!);
let img2 = CIImage(contentsOf: url)
let bbimg = blur(radius: 0.5)(img2!)
imageView.image = UIImage(ciImage: bbimg)
