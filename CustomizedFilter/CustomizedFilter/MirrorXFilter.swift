//
//  MirrorXFilter.swift
//  CustomizedFilter
//
//  Created by birneysky on 2019/5/23.
//  Copyright © 2019 Grocery. All rights reserved.
//

import UIKit

class MirrorXFilter: CIFilter {
    
    static var kernel: CIKernel?  {
        let bundle = Bundle.main
        guard let url =  bundle.url(forResource: "MirrorX", withExtension: "cikernel") else {
            fatalError("file not found")
        }
        do {
            let kernelCode = try String(contentsOf: url)
            guard let kernel = CIKernel(source: kernelCode) else {
                fatalError("file not found")
                
            }
            return kernel
        } catch {
            
        }
        return nil
    }
    
    override init() {
        super.init()

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
