//
//  TestImageViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/16.
//

import UIKit

/**
 1. 如果光标前出现连续两个以上#，弹出面板，使用 ”“ 搜索  例如#abc##abc↑
 2. 如果光标前出现一段非#文本，并且非#文本前出现完成话题，关闭面板。例如#abc#abc↑
 3. 如果光标出现在一个完整话题内， 当用户输入时，显示面板，使用两个##之间的内容搜索。 例如#a↑bc#
 4. 如果光标前出现一段非#文本，并且从后向前离光标最近的# 之前存在非# 文本，非本文本之前有一个完整话题 ，
 这种情况下，弹出面板，并检索 abc 。例如 #abc#def#a↑bc
 5.  如果光标处在一段非#文本中，该文本前存在完成话题， 关闭面板  例如#abc#a↑bc#def
 6. 如果光标处在2个#之间并且前后存在完成话题，且输入# 使用“”搜索，弹出面板 例如#abc#↑#def#
 7. 如果光标处在2个#之间并且前后存在完成话题，且输入# 使用“”搜索，弹出面板 例如#abc#↑#def
 
 
 */

class TestImageViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let view  = KTVShiningEffectLabel(gradientColors: [
            rgba("#CA7D00FF"),
            rgba("#CA7D00FF"),
            rgba("#FFEB01FF"),
            rgba("#FFEB01FF"),
            rgba("#CA7D00FF"),
            rgba("#CA7D00FF"),
        ], locations: [
            0, 0.34, 0.37, 0.48, 0.5, 1
        ], startPoint: CGPoint(x: 0, y: 0.5),
         endPoint: CGPoint(x: 1, y: 0.5))
        view.text = "wa123456💦"
        view.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints  = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -300)

        ])
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var prevText: String = ""

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
        return true
        guard let textRange = Range(range, in: textView.text) else { return false }
        if let selectedRange = textView.selectedTextRange {
            let cursorPosition = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            
            let updatedText = textView.text.replacingCharacters(in: textRange, with: text)
            
             let macthes = updatedText.allmatchs(pattern: "#([^#]+)#") ?? []
            // 计算新光标位置
            var newCursorPosition = cursorPosition + text.count - range.length
            print("####################")
            if newCursorPosition == 0 {
                return true
            }
            
            var position = 0
            if text == "" || text == "#" {
                position = cursorPosition
            } else {
                position =  newCursorPosition
//
//                newCursorPosition -= 1
//                if newCursorPosition < 0 {
//                    newCursorPosition = 0
//                }
//                
//                if newCursorPosition == updatedText.count - 1 {
//                    newCursorPosition += 1
//                }
            }
//            if text == "" || text == "#" {
//                newCursorPosition -= 1
//                if newCursorPosition < 0 {
//                    newCursorPosition = 0
//                }
//            }

            print("----- \(position)")
            for match in macthes {
                print("------ \(match.range)")
                if match.range.contains(position) {
                    if let textRange1 = Range(match.range, in: updatedText) {
                        print("------ \(String(updatedText[textRange1]))")
                        return true;
                    }
                }
                    
            }
//            if let matchText = updatedText.subString(pattern: "[^#]*#{1,}([^#]+)", in: newCursorPosition) {
//               print("-----5 replace \(cursorPosition) \(matchText)")
//            }
            
            return true;
           /**
            
            4: #somestring
            4: #####somestring
            5: somestring0#somestring
            5: somestring0######somestring
            7 #somestring0#somestring1#somestring
            
            ///  #abcdef###aod#abc#def |    ❌
            ///  #abcdef###aodef##abf| ❌
            */
            /// #ade##abcdefab|c
            /// #ade##abcdefab|c#
            /// #ade###abcdefab|c#
            
            if let matchText = updatedText.subString(pattern: "#[^#]*#{2,}([^#]*|\\w*)", in: newCursorPosition) {
                print("-----6 replace \(cursorPosition) \(matchText)")
            }
            /// #abcdef
            else if let matchText = updatedText.subString(pattern: "^#([^#]*)$", in: newCursorPosition) {
                print("-----2 replace \(cursorPosition) \(matchText)")
            }
            
            /// #abc#def|
            /// #ab###abc#def|
//            if let tt = updatedText.subString(pattern: "#[^#]*#([^#]*|\\w*)", in: newCursorPosition) {
//                print("-----3 replace \(cursorPosition) \(tt)")
//            }
            
            /// #ab|c#def
            else if let matchText = updatedText.subString(pattern: "#([^#]*|\\w*)#[^#]*", in: newCursorPosition) {
                print("-----4 replace \(cursorPosition) \(matchText)")
            }
            
            
            else if let matchText = updatedText.subString(pattern: "#[^#]*#{2,}([^#]+)", in: newCursorPosition) {
                print("-----5 replace \(cursorPosition) \(matchText)")
            }
            // #abc###abc#defac|
            else if let matchText = updatedText.subString(pattern: "#{2,}[^#]*#[^#]*#([^#]+)", in: newCursorPosition) {
                print("-----7 replace \(cursorPosition) \(matchText)")
            }
            /// #abc###abc#defabc#abc#
            else if let matchText = updatedText.subString(pattern: "#[^#]*#[^#]*#([^#]+)", in: newCursorPosition) {
                print("-----8 replace \(cursorPosition) \(matchText)")
            } else {
                let cursorIndex = updatedText.index(updatedText.startIndex, offsetBy: newCursorPosition)
                if updatedText[cursorIndex] == "#" {
                    if newCursorPosition == 0 {
                        print("------- \"\"")
                    } else if newCursorPosition > 1 { 
                        let cursorPrevIndex = updatedText.index(updatedText.startIndex, offsetBy: newCursorPosition - 1)
                        if updatedText[cursorPrevIndex] == "#" {
                            print("------- \"\"")
                        }
                    }
                }
            }
            
//            if let tt = updatedText.subString(pattern: "#[^#]*#{2,}([^#]*)#", in: newCursorPosition) {
//                        print("-----2 replace   \(cursorPosition) \(tt)")
//            }
            ///
        }
        return true;
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("#################### begin")
        if let selectedRange = textView.selectedTextRange {
            var cursorPosition = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            guard let updatedText = textView.text else { fatalError()}
            
            
            
            if updatedText.count > prevText.count {
                cursorPosition -= 1;
                var cursorIndex = updatedText.index(updatedText.startIndex, offsetBy: cursorPosition)
                cursorIndex = updatedText.index(updatedText.startIndex, offsetBy: cursorPosition)
                print("----- \(cursorPosition), \(updatedText[cursorIndex])")
                if updatedText[cursorIndex] == "#" {
                    //cursorPosition += 1
                }
            } else {
            
            }
            
            print("----- \(cursorPosition)")
            let macthes = updatedText.allmatchs(pattern: "#([^#]+)#") ?? []
            print("------ macthes count\(macthes.count)")
            for match in macthes {
                let range = NSRange(location: match.range.location + 1, length: match.range.length - 2)
                print("------ \(range)")
                if range.contains(cursorPosition) {
                    if let textRange1 = Range(range, in: updatedText) {
                        print("------ taget \(String(updatedText[textRange1]))")
                        print("#################### end")
                        return ;
                    }
                }
                    
            }
            if let lastRange = macthes.last?.range, let firstRange = macthes.first?.range, cursorPosition < lastRange.location + lastRange.length && cursorPosition > firstRange.location {
                print("#################### return")
                return
            }
            var  tailText = updatedText
            if let range = macthes.last?.range,
                cursorPosition >= range.location + range.length,
               let textRange = Range(range, in: updatedText) {
                
                print("---\(textRange)")
                tailText = String(updatedText[textRange.upperBound...])
                cursorPosition -= range.location + range.length
                
            }
            
            
            print("---------- tailText:\(tailText)")
            if tailText == "#" {
                print("-----1 DidChange \"\"")
            } else if tailText.isMatch(pattern: "[^#]#$|#{2,}$") {
                print("-----2 DidChange \"\"")
            } else if let tt = tailText.subString(pattern: "#([^#]*)", in: cursorPosition) {
                print("-----3 DidChange \(cursorPosition) \(tt)")
            }
            /*
            if let tt = textView.text.subString(pattern: "#[^#]*#{2,}([^#]*)#*", in: cursorPosition - 1) {
                print("-----1 DidChange \(cursorPosition) \(tt)")
            }
            
            if let tt = textView.text.subString(pattern: "#([^#]*)", in: cursorPosition - 1) {
                print("-----2 DidChange \(cursorPosition) \(tt)")
            }
            
            
            if let tt = textView.text.subString(pattern: "[^#]#+([^#]*)", in: cursorPosition - 1) {
                print("-----3 DidChange \(cursorPosition) \(tt)")
            }*/
            
            print("#################### end")
            print("\n\n")
            
        }
        prevText = textView.text;
    }
}

@available(iOS 17.0, *)
#Preview{
    let controller = TestImageViewController.controller()
    return controller;
}
