import Foundation
import CoreImage

public typealias Filter = (CIImage) -> CIImage

public func blur(radius: Double) -> Filter {
    return { image in
        let parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ] as [String:Any]
        guard let filter = CIFilter(name: "CIGaussianBlur", parameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError("outputimage is nil")
        }
        return outputImage;
    }
}
