//
//  ViewController.swift
//  PromiseKitDemo
//
//  Created by birney on 2019/7/15.
//  Copyright © 2019 RongCloud. All rights reserved.
//

import UIKit

struct User {
    var name: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        firstly {
//            login()
//        }.done { (_) in
//
//        }
        
        
        let rp = Promise<String>(.pending)
        let body = {
            return Promise<String> { resolver in
                 resolver.fulfill("abc")
            }
        }
        let abcpromise = body()
        let to = rp.box.seal
        abcpromise.pipe(to: to)
        rp.then { token  in
            Promise<String> { resolver in
                resolver.fulfill("def")
            }
        }
    }

    func login() -> Promise<()> {
        return Promise { (resolver) in
                resolver.fulfill(())
        }

    }


}

