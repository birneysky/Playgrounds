//
//  ViewController.swift
//  PromiseKitDemo
//
//  Created by birney on 2019/7/15.
//  Copyright © 2019 RongCloud. All rights reserved.
//

import UIKit
import GroceryKit

struct User {
    var name: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstly {
            login()
        }.done { (_) in
                
        }
    }

    func login() -> Promise<()> {
        return Promise { (resolver) in
                resolver.fulfill(())
        }

    }


}

