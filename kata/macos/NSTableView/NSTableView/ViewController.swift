//
//  ViewController.swift
//  NSTableView
//
//  Created by Bruce on 2022/5/2.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    var data = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableStyleConfig()
        self.updateData()
        // Do any additional setup after loading the view.
    }
    
    func tableStyleConfig() {
        self.tableView.gridStyleMask = [.dashedHorizontalGridLineMask, .solidVerticalGridLineMask]
        self.tableView.backgroundColor = .blue
        self.tableView.usesAlternatingRowBackgroundColors = true
        self.tableView.selectionHighlightStyle = .sourceList
    }
    
    func updateData() {
        self.data = [
            ["name" : "john", "address" : "USA", "gender" : "male", "married" : (1)],
            ["name" : "mary", "address" : "China", "gender" : "female", "married" : (0)],
            ["name" : "park", "address" : "Japan", "gender" : "male", "married" : (0)],
            ["name" : "Daba", "address" : "Russia", "gender" : "female", "married" : (1)],
            ["name" : "john", "address" : "USA", "gender" : "male", "married" : (1)],
            ["name" : "mary", "address" : "China", "gender" : "female", "married" : (0)],
            ["name" : "park", "address" : "Japan", "gender" : "male", "married" : (0)],
            ["name" : "Daba", "address" : "Russia", "gender" : "female", "married" : (1)]
        ]
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController : NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let d = self.data[row];
        let key = tableColumn?.identifier;
        let value = d[key!]
        return value
    }
}

