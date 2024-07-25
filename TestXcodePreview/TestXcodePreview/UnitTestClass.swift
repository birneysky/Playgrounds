//
//  UnitTestClass.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/24.
//

import UIKit

@objc class UnitTestClass: NSObject {
    @objc func test() {
        
    }
}

/**
 
 1: #somestring0##somestring#somestring1
 2: #somestring0#somestring1#somestring
 3: #somestring0##somestring
 4: #somestring
 4: #####somestring
 5: somestring0#somestring
 5: somestring0######somestring
 7 #somestring0#somestring1#somestring

 以上五种字符串形式，匹配获取somestring 串所在范围的字符串内容 ,somestring 表示任意不包含#的字符串 . 请根据的这些字符串形式，请写出正则表达式，并解释为什么这么写

  #[^#]*#{2,}([^#]*)#*

 #+([^#]*)

 [^#]#+([^#]*)

 
 •  [^#]*：匹配零个或多个非 # 字符。

 •  #+：匹配一个或多个 # 字符。

 •  ([^#]*)：捕获零个或多个非 # 字符。

 •  #*：匹配零个或多个 # 字符。
 
 /// #{2,}表示至少有2个 #
 
 */
extension String {
    func subString(pattern: String ,in cursorPosition: Int) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))

            for match in matches {
                /**
                 为什么使用 range(at: 1) 而不是 range(at: 0)
                 •  range(at: 0) 获取的是整个匹配的范围，而不是特定的捕获组。

                 •  range(at: 1) 获取的是第一个捕获组的范围。如果你的正则表达式有多个捕获组，你可以使用 range(at: n) 来获取第 n 个捕获组的范围。
                 */
                let matchRange = match.range(at: 1)
                if matchRange.location != NSNotFound, let range = Range(matchRange, in: self) {
                    if range.contains(self.index(self.startIndex, offsetBy: cursorPosition)) {
                        return String(self[range])
                    }
                }
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
            return nil
        }

        return nil
    }
    
    func allmatchs(pattern: String) -> [NSTextCheckingResult]? {
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
            } catch {
                print("Invalid regex: \(error.localizedDescription)")
                return nil
            }
        }
}




