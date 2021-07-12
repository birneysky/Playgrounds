//
//  MirrorXFilter.swift
//  CIFilters
//
//  Created by Bruce on 2021/7/9.
//  Copyright © 2021 COOL. All rights reserved.
//

import UIKit
import Foundation

class MirrorXFilter: CIFilter {
    private static var kernel = MirrorKernel()
    var inputImage: CIImage!

    override init() {
        super.init()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var outputImage: CIImage? {
        guard let extent = self.inputImage?.extent else {
            return nil
        }
        let inputWidth = extent.width
        let callback: CIKernelROICallback = {index, rect in
            return rect
        }
        return Self.kernel.mirrorX.apply(extent: extent,
                                         roiCallback: callback,
                                         image: self.inputImage,
                                         arguments: [inputWidth]);
        
    }
    
    struct MirrorKernel {
        var mirrorX: CIWarpKernel!
        init() {
            guard let kernelUrl = Bundle.main.url(forResource: "default",
                                            withExtension: "metallib") else {
                return;
            }
            do {
                let data = try Data(contentsOf: kernelUrl)
                mirrorX = try CIWarpKernel(functionName: "mirrorX", fromMetalLibraryData: data)
            } catch  {
                print("Unexpected error: \(error).")
            }
            
            
        }
    }
}
