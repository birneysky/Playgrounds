//
//  main.swift
//  OCR
//
//  Created by Bruce on 2025/2/8.
//

import Foundation
import Vision
import AppKit
import CoreImage

func recognizeText(in image: NSImage) {
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return }
    
    let request = VNRecognizeTextRequest { request, error in
        guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else { return }
        
        let attributedString = NSMutableAttributedString()
        // 按照 y 坐标对观察结果进行排序
        let sortedObservations = observations.sorted { $0.boundingBox.origin.y > $1.boundingBox.origin.y }
        
        var lines: [[VNRecognizedTextObservation]] = []
        var currentLine: [VNRecognizedTextObservation] = []
        var currentMidY: CGFloat = sortedObservations.first?.boundingBox.midY ?? 0
        for observation in sortedObservations {
            let observationMidY = observation.boundingBox.midY
            if abs(observationMidY - currentMidY) <= 0.002 {
                currentLine.append(observation)
            } else {
                lines.append(currentLine)
                currentLine = [observation]
                currentMidY = observationMidY
            }
        }
        // 添加最后一行
          if !currentLine.isEmpty {
              lines.append(currentLine)
          }
        
        for line in lines {
            let sortedLine = line.sorted { $0.boundingBox.midX < $1.boundingBox.midX }
            for (index, observation) in sortedLine.enumerated() {
                guard let text = observation.topCandidates(1).first?.string else { continue }
                let boundingBox = observation.boundingBox
                //print("\(text):\(boundingBox.midX),\(boundingBox.midY)", terminator: " ")
                // 转换坐标系（Vision 左下角原点 → Core Graphics 左上角原点）
                let transformedRect = VNImageRectForNormalizedRect(boundingBox, cgImage.width, cgImage.height)
                let y = CGFloat(cgImage.height) - transformedRect.origin.y - transformedRect.height
                let adjustedRect = CGRect(x: transformedRect.origin.x, y: y, width: transformedRect.width, height: transformedRect.height)
                
                // 提取样式信息
                let color = extractColor(from: cgImage, rect: adjustedRect).withSystemEffect(.deepPressed)
                let backgroudColor = extractBackgroundColor(from: cgImage, rect: adjustedRect)
                let fontSize = estimateFontSize(adjustedRect.height)
                let font = NSFont.systemFont(ofSize: fontSize) // 默认系统字体（可替换为实际字体）
                // 输出富文本（示例为 HTML）
                //            let styledText = "<span style=\"color: \(color.hexString); font-size: \(fontSize)px;\">\(text)</span>"
                //            print(styledText)
                
                // 创建属性字典
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: color,
                    //.backgroundColor: NSColor.white,
                    .font: font
                ]
                
                
                //            let lines = text.split(separator: "\n", omittingEmptySubsequences: false)
                //             for (index, line) in lines.enumerated() {
                //                 let attributedSegment = NSAttributedString(string: String(line), attributes: attributes)
                //                 attributedString.append(attributedSegment)
                //                 if index < lines.count - 1 {
                //                     attributedString.append(NSAttributedString(string: "\n", attributes: attributes))
                //                 }
                //             }
                
//                // 保留换行符和空格
//                let lines = text.split(separator: "\n", omittingEmptySubsequences: false)
//                for (index, line) in lines.enumerated() {
//                    let attributedSegment = NSAttributedString(string: String(line), attributes: attributes)
//                    attributedString.append(attributedSegment)
//                    //print("\(line)",terminator:" ")
//                    if index < lines.count - 1 {
//                        attributedString.append(NSAttributedString(string: "\n", attributes: attributes))
//                        //print("\n")
//                    }
//                }
                print("\(text)")
                let attributedSegment = NSAttributedString(string: text, attributes: attributes)
                attributedString.append(attributedSegment)
                //print("\(attributedSegment.string)",terminator:" ")
                if index != sortedLine.count - 1 {
                    attributedString.append(NSAttributedString(string: " "))
                    //print(" ",terminator:" ")
                }
  
                
            }
            attributedString.append(NSAttributedString(string: "\n"))
            print("")
        }
        
        //print("文本: \(text), 颜色: \(color), 字号: \(fontSize)")
        
        do {
             let rtfData = try attributedString.data(from: NSRange(location: 0, length: attributedString.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setData(rtfData, forType: .rtf)
            
         } catch {
             print("Error converting to RTF: \(error)")
         }
   
        //print("\(attributedString.string)")
    }
    request.recognitionLevel = .accurate // 高精度模式
    request.recognitionLanguages = ["zh-Hans", "zh-Hant", "en-US"]
    
    let handler = VNImageRequestHandler(cgImage: cgImage)
    try? handler.perform([request])
}

func extractColor(from cgImage: CGImage, rect: CGRect) -> NSColor {
    guard let croppedImage = cgImage.cropping(to: rect) else { return .black }
    let bitmap = NSBitmapImageRep(cgImage: croppedImage)
    var colorMap: [NSColor: Int] = [:]
    
    // 统计主要颜色
    for x in 0..<bitmap.pixelsWide {
        for y in 0..<bitmap.pixelsHigh {
            if let color = bitmap.colorAt(x: x, y: y) {
                colorMap[color] = (colorMap[color] ?? 0) + 1
            }
        }
    }
    // 返回出现次数最多的颜色
    return colorMap.max { $0.value < $1.value }?.key ?? .black
}

func extractBackgroundColor(from cgImage: CGImage, rect: CGRect) -> NSColor {
    guard let croppedImage = cgImage.cropping(to: rect) else { return .white }
    
    // 使用 Core Image 区域平均滤镜
    let ciImage = CIImage(cgImage: croppedImage)
    guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: ciImage]) else {
        return .white
    }
    
    let context = CIContext()
    guard let outputImage = filter.outputImage,
          let cgOutput = context.createCGImage(outputImage, from: outputImage.extent) else {
        return .white
    }
    
    let bitmap = NSBitmapImageRep(cgImage: cgOutput)
    return bitmap.colorAt(x: 0, y: 0) ?? .white
}

// MARK: - 改进版文字颜色提取
func extractDominantTextColor(from cgImage: CGImage, rect: CGRect) -> NSColor {
    guard let croppedImage = cgImage.cropping(to: rect) else { return .black }
    
    // Step 1: 转换为 Core Image 对象
    let ciImage = CIImage(cgImage: croppedImage)
    
    // Step 2: 自动二值化处理（使用 Core Image 内置滤镜）
    guard let thresholdFilter = CIFilter(name: "CIColorThreshold") else { return .black }
    thresholdFilter.setValue(ciImage, forKey: kCIInputImageKey)
    thresholdFilter.setValue(0.7, forKey: "inputThreshold") // 可调参数
    
    // Step 3: 生成文字蒙版
    guard let maskImage = thresholdFilter.outputImage else { return .black }
    
    // Step 4: 应用蒙版到原图
    guard let blendFilter = CIFilter(name: "CIBlendWithMask") else { return .black }
    blendFilter.setValue(ciImage, forKey: kCIInputImageKey)
    blendFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)
    
    // Step 5: 分析文字像素颜色
    let context = CIContext()
    guard let outputImage = blendFilter.outputImage,
          let cgOutput = context.createCGImage(outputImage, from: outputImage.extent) else {
        return .black
    }
    
    // Step 6: 统计有效像素颜色
    let bitmap = NSBitmapImageRep(cgImage: cgOutput)
    var colorFrequency: [NSColor: Int] = [:]
    
    bitmap.pixelsWide
    bitmap.pixelsHigh
    
    for x in 0..<bitmap.pixelsWide {
        for y in 0..<bitmap.pixelsHigh {
            guard let color = bitmap.colorAt(x: x, y: y),
                  color.alphaComponent > 0.1 else { continue }
            
            // 忽略透明/半透明像素
            let quantized = color.quantized(toBits: 3) // 降低颜色精度减少噪点
            colorFrequency[quantized] = (colorFrequency[quantized] ?? 0) + 1
        }
    }
    
    // 返回出现频率最高的非背景色
    return colorFrequency.max { $0.value < $1.value }?.key ?? .black
}

// NSColor 转 Hex 字符串扩展
extension NSColor {
    var hexString: String {
        guard let rgbColor = usingColorSpace(.sRGB) else { return "#000000" }
        let red = Int(round(rgbColor.redComponent * 0xFF))
        let green = Int(round(rgbColor.greenComponent * 0xFF))
        let blue = Int(round(rgbColor.blueComponent * 0xFF))
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
    
    func quantized(toBits bits: Int) -> NSColor {
        let factor = CGFloat((1 << bits) - 1)
        let r = round(self.redComponent * factor) / factor
        let g = round(self.greenComponent * factor) / factor
        let b = round(self.blueComponent * factor) / factor
        return NSColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

func estimateFontSize(_ rectHeight: CGFloat) -> CGFloat {
    // 经验系数：字体大小 ≈ 区域高度 × 0.6（根据实际情况调整）
    return rectHeight * 0.6
}

// 读取命令行参数
let arguments = CommandLine.arguments
for argument in arguments {
    print("Argument: \(argument)")
}

// 示例：读取文件内容
if arguments.count > 1 {
    let filePath = arguments[1]
    do {
       // let contents = try String(contentsOfFile: filePath, encoding: .ascii)
        if let image = NSImage(contentsOfFile: filePath) {
            recognizeText(in: image)
        } else {
            print("image is nil")
        }
        
        
    } catch {
        print("Error reading file: \(error)")
    }
}
