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
        let body = { () -> Promise<String> in
            print("hello world")
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
        
        let closure = { () -> Int in
            let b = 4
            let c = 5
            print("abc")
            return b+c
        }
        
        let a = closure()
        print(a)
    }

    func login() -> Promise<()> {
        return Promise { (resolver) in
                resolver.fulfill(())
        }

    }


}

