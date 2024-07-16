//
//  WKWebViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/16.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let htmlString = """
        <html>
        <body>
        <h1>Hello, World!</h1>
        <iframe src="https://changba.com/auto/view/7CC1C0CfAb" frameborder="0"></iframe>
        </body>
        </html>
        """
        webview.loadHTMLString(htmlString, baseURL: nil)
//        if let url = URL(string: "https://www.baidu.com") {
//            let reqeust = URLRequest(url: url)
//            webview.load(reqeust)
//        }
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


#Preview {
    let controller = WKWebViewController.controller()
    return controller;
}
