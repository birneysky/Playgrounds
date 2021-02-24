//
//  ViewController.swift
//  Diagram
//
//  Created by Bruce on 2021/2/24.
//

import UIKit

class ViewController: UIViewController {
    var rect1: UIView!
    var rect2: UIView!
    var line = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rect1 = UIView(frame: CGRect(x: 50, y: 150, width: 40, height: 40))
        rect1.backgroundColor = UIColor.orange
        self.view.addSubview(rect1)
        
        rect2 = UIView(frame: CGRect(x: 200, y: 150, width: 40, height: 40))
        rect2.backgroundColor = UIColor.yellow
        self.view.addSubview(rect2)
        
        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(dragView(_:)))
        self.rect1.addGestureRecognizer(panGesture1)
        
        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(dragView(_:)))
        self.rect2.addGestureRecognizer(panGesture2)
        self.addLine(from: rect1.center, to: rect2.center)
    }
    
    func addLine(from: CGPoint, to: CGPoint) {
        line.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to: from)
        linePath.addLine(to: to)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 2
        line.lineJoin = CAShapeLayerLineJoin.round
        self.view.layer.addSublayer(line)
    
    }
    
    @objc func dragView(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self.view)
        let draggedView = sender.view
        guard let aDraggedView = draggedView else {
            return;
        }
        aDraggedView.center = point
        addLine(from: rect1.center, to: rect2.center)
    }


}

