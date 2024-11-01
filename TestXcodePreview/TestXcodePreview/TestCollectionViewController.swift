//
//  TestCollectionViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/5/22.
//

import UIKit

private let reuseIdentifier = "TestCollectionViewCell"

class TestCollectionViewController: UICollectionViewController {
    var dataSource = [
        "Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item",
        "Uncomment these methods",
        "In a storyboard-based application",
        "you will often want to do a little preparation before navigation",
        "self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)Do any additional setup after loading the view.",
        
        "Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item",
        "Uncomment these methods",
        "In a storyboard-based application",
        "you will often want to do a little preparation before navigation",
        "self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)Do any additional setup after loading the view.",
        "Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item",
        "Uncomment these methods",
        "In a storyboard-based application",
        "you will often want to do a little preparation before navigation",
        "self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)Do any additional setup after loading the view.",
        "Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item",
        "Uncomment these methods",
        "In a storyboard-based application",
        "you will often want to do a little preparation before navigation",
        "self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)Do any additional setup after loading the view.",
        "Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item",
        "Uncomment these methods",
        "In a storyboard-based application",
        "you will often want to do a little preparation before navigation",
        "self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)Do any additional setup after loading the view.",
        "Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item",
        "Uncomment these methods",
        "In a storyboard-based application",
        "you will often want to do a little preparation before navigation",
        "self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)Do any additional setup after loading the view.",
        "Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item",
        "Uncomment these methods",
        "In a storyboard-based application",
        "you will often want to do a little preparation before navigation",
        "self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)Do any additional setup after loading the view.",
        "123",
        "a", "b", "c", "d", "f"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let nib = UINib(nibName: "TestCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
//        self.collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20000
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TestCollectionViewCell
    
        // Configure the cell
        //cell.backgroundColor = .red
        let totalCount = dataSource.count
        cell.label.text = dataSource[indexPath.item % totalCount]
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

@available(iOS 17.0, *)
#Preview{
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    layout.estimatedItemSize = CGSizeMake(44, 44)
    let controller = TestCollectionViewController(collectionViewLayout: layout)
    return controller;
}
