//
//  MirrorXFilter.swift
//  CustomizedFilter
//
//  Created by birneysky on 2019/5/23.
//  Copyright © 2019 Grocery. All rights reserved.
//

import UIKit

class MirrorXFilter: CIFilter {
    
    fileprivate static var kernel: CIWarpKernel?  =  {
        let bundle = Bundle.main
        guard let url =  bundle.url(forResource: "MirrorX", withExtension: "cikernel") else {
            fatalError("file not found")
        }
        do {
            let kernelCode = try String(contentsOf: url)
            guard let kernel = CIWarpKernel(source: kernelCode) else {
                fatalError("file not found")
                
            }
            return kernel
        } catch {
            
        }
        return nil
    }()
    
    public var inputImage: CIImage?
    
    override var outputImage: CIImage? {
        guard let inputimg = inputImage else {
            return nil
        }
        let inputWidth = inputimg.extent.width
        return MirrorXFilter.kernel?.apply(extent: inputimg.extent, roiCallback: { (index, rect) -> CGRect in
            return rect
        }, image: inputimg, arguments: [inputWidth]);
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
