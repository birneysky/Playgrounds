//
//  KTVGussUSearchViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/11/1.
//

import UIKit

class KeywordCell: UICollectionViewCell {
    
    let keywordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = UIColor(white: 0.9, alpha: 1)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        return label
    }()
    
    let leftImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
        ])
        return imageView
    }()
    
    
    let rightImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 12),
        ])
        return imageView
    }()
    
    let container: UIStackView = {
       let view = UIStackView()
//        view.alignment = .center
//        view.distribution = .equalSpacing
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.axis = .horizontal
        view.spacing = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(self.container)
        //container.addArrangedSubview(leftImageview)
        container.addArrangedSubview(keywordLabel)
        //container.addArrangedSubview(rightImageview)
        //contentView.addSubview(keywordLabel)
        
        // 设置 Auto Layout 约束
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with keyword: String) {
        keywordLabel.text = keyword
    }
    
}

class KTVGussUSearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    private var searchHistory: [String] = ["你好","哈喽","哇哈哈","一二三","四五六","789","8909"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewLayout.minimumLineSpacing = 5
        self.collectionViewLayout.minimumInteritemSpacing = 5
        collectionView.register(KeywordCell.self, forCellWithReuseIdentifier: "KeywordCell")
        collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layoutIfNeeded()
        let collectionViewHeight = self.collectionView.contentSize.height
        let height: CGFloat = collectionViewHeight + 20 + 18 + 16 + 8
        self.view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        
        print("################12345 \(self.collectionView.contentSize.height) ,height:\(height) :hahah:\(collectionViewHeight)")
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func refreshAction(_ sender: UIButton) {
        print("hahhaha")
    }
    
    // MARK: - UICollectionViewDataSource
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return searchHistory.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath) as! KeywordCell
            cell.configure(with: searchHistory[indexPath.item])
            cell.backgroundColor = .red
            return cell
        }
        
        // MARK: - UICollectionViewDelegate
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedKeyword = searchHistory[indexPath.item]
           
        }
}


@available(iOS 17.0, *)
#Preview{
    
    let parentController = UIViewController()
    parentController.view.backgroundColor = .white
    let controller = KTVGussUSearchViewController.controller()
    controller.view.backgroundColor = .blue
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        //controller.view.heightAnchor.constraint(equalToConstant: 176),
    ])
    return parentController;
}
