//
//  TestImageViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/16.
//

import UIKit

class TestImageViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

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

    func checkxxxx(text: String) -> Bool {
        let pattern = ".*#([^#]+#)+.*"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: text.utf16.count)
            
            if let _ = regex.firstMatch(in: text, options: [], range: range) {
                return true
            } else {
                return false
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textRange = Range(range, in: textView.text) else { return false }
        let updatedText = textView.text.replacingCharacters(in: textRange, with: text)
        let cursorPosition = range.location + (text as NSString).length
        let searchRange =  Range(NSRange(location: 0, length: cursorPosition), in: updatedText)
        // 查找光标前的最后一个 #
        if let precedingHashRange = updatedText.range(of: "#", options: .backwards, range: searchRange, locale: nil) {
            

            
            //let precedingText = updatedText[precedingHashRange]//(currentText as NSString).substring(from: precedingHashRange.location + 1)
            let precedingText = updatedText[precedingHashRange.lowerBound...]
            print("##### \(precedingText) \(updatedText)")
            if let nextHashRange = precedingText.range(of: "#") {
                // 两个 # 之间的内容
                //let content = precedingText[nextHashRange]//(precedingText as NSString).substring(to: nextHashRange.location)
                let content = precedingText[nextHashRange.upperBound...]
                
                if content.count <= 0, checkxxxx(text: updatedText) {
                    print("#####  dismiss")
                    return true
                }
                //showPanel(withText: content)
                print("#####  show one content \(content)")
            } else {
                // 光标前有一个 #
                //showPanel(withText: precedingText)
                print("#####  show two content \(precedingText)")
            }
        } else {
            // 光标前没有 #
            ///hidePanel()
            print("#####  dismiss")
        }
        return true;
    }
}

#Preview {
    let controller = TestImageViewController.controller()
    return controller;
}
