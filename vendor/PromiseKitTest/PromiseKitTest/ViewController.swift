//
//  ViewController.swift
//  PromiseKitTest
//
//  Created by birney on 2019/7/17.
//  Copyright © 2019 RongCloud. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let name = "name"
        let hc = HtppClient()
        
        //// firstly  then 块中只能包含一行代码
        firstly {
            hc.fetchToken(uid: "123", name: name)
        }.then { (token) in
            hc.fetchToken(uid: "xfdas", name: "are you ok")
        }.done { token in
            print("2 \(token)")
        }.catch { err in
            print(err)
        }
        
        secondly {
            print("secondly")
        }
        
    }
    
    
    func secondly(execute body: ()->Void) {
        body()
    }


}

