//
//  KTVLRSendRedPacketViewController.swift
//  ktv
//
//  Created by Bruce on 2024/6/13.
//

import UIKit

class KTVLRSendRedPacketViewController: UIViewController {

    @IBOutlet weak var roundedView: KTVPartialRoundedView!
    @IBOutlet weak var redPacketNumTextField: UITextField!
    @IBOutlet weak var commandTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var redPacketSurvivalTimeCollectionView: UICollectionView!
    @IBOutlet weak var redPacketAmoutCollectionView: UICollectionView!
    @IBOutlet weak var amountCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commandTextFieldContainer: UIStackView!
    @IBOutlet weak var moneyButton: UIButton!
    @IBOutlet weak var commandButton: UIButton!
    private let reuseIdentifier = "KTVLRSendRedPacketTextItemCell"
    var viewModel = KTVLRSendRedPacketViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let maxHeight:CGFloat = 620;
//        self.view.height = maxHeight;
//        self.view.width = UIScreen.main.bounds.size.width
        self.view.backgroundColor = .clear

        registerCollectionCell()
        registNotification()
        addGesture()
        bindViewModel()
        
        viewModel.getData()
    }
    
    override func loadView() {
        super.loadView()
        self.roundedView.corners = [.topLeft, .topRight]
        self.scrollView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 0, right: 0)
        
        setupRedPacketNumTextField()
        
        setupCommandTextField()
        
    }
    
    // MARK: - Helper
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
              view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    private func registerCollectionCell() {
        let nib = UINib(nibName: "KTVLRSendRedPacketTextItemCell", bundle: nil)
        self.redPacketAmoutCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        self.redPacketSurvivalTimeCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    private func registNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func setupRedPacketNumTextField() {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 28))
        rightView.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 28))
        label.text = "个"
        label.textColor = rgba("##FF334899")
        label.textAlignment = .center
        rightView.addSubview(label)
        redPacketNumTextField.rightViewMode = .always
        redPacketNumTextField.rightView = rightView
        redPacketNumTextField.layer.cornerRadius = 14
        redPacketNumTextField.layer.borderColor = rgba("#FF3348FF").cgColor
        redPacketNumTextField.layer.borderWidth = 0.5
        redPacketNumTextField.layer.masksToBounds = true
        
        commandTextField.layer.cornerRadius = 14
        commandTextField.layer.borderColor = rgba("#FFFFFF33").cgColor
        commandTextField.layer.borderWidth = 0.5
        commandTextField.layer.masksToBounds = true
    }
    
    private func  setupCommandTextField() {
        let placeholderText = " 输入口令"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: rgba("#FFFFFF99"),
            .font: UIFont.systemFont(ofSize: 12)
        ]
        commandTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    }
    
    private func setupParticipationButtons() {
    }
    
    
    
    func bindViewModel() {
        viewModel.isLoading.bind {[weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            if (isLoading) {
                //self.showLoadingView()
            } else {
                //self.hideLoadingView()
            }
        }
        
        viewModel.amountDataSource.bind {[weak self] amounts in
            guard let self = self, let _ = amounts else {
                return
            }
            print("-------------")
            self.redPacketAmoutCollectionView.reloadData()
            self.redPacketAmoutCollectionView.layoutIfNeeded()
            self.amountCollectionHeightConstraint.constant = self.redPacketAmoutCollectionView.contentSize.height
            self.view.layoutIfNeeded()
            self.redPacketAmoutCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
        }
        
        
        viewModel.timeDataSource.bind {[weak self] times in
            guard let self = self, let _ = times else {
                return
            }
            print("######")
            self.redPacketSurvivalTimeCollectionView.reloadData()
            self.redPacketSurvivalTimeCollectionView.layoutIfNeeded()
            self.timeCollectionHeightConstraint.constant = self.redPacketSurvivalTimeCollectionView.contentSize.height
            self.view.layoutIfNeeded()
            self.redPacketSurvivalTimeCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
        }
        
        viewModel.participationType.bind {[weak self] type in
            guard let self = self, let type = type else {
                return
            }
            if type == .command {
                self.commandButton.isSelected = true
                self.moneyButton.isSelected = false
                self.commandButton.backgroundColor = rgba("#FF334833")
                self.moneyButton.backgroundColor = rgba("#FFFFFF1A")
                self.commandTextFieldContainer.isHidden = false
            } else if type == .money {
                self.commandButton.isSelected = false
                self.moneyButton.isSelected = true
                self.moneyButton.backgroundColor = rgba("#FF334833")
                self.commandButton.backgroundColor = rgba("#FFFFFF1A")
                self.commandTextFieldContainer.isHidden = true
            } else {
                fatalError()
            }
        }
    }
    
    // MARK: - Notification Selector
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let commandTextFieldContainer = commandTextField.superview {
              let keyboardHeight = keyboardSize.height
              let textFieldFrame = commandTextFieldContainer.convert(commandTextFieldContainer.bounds, to: view)
              let textFieldBottomY = textFieldFrame.origin.y + textFieldFrame.height
              let visibleHeight = view.frame.height - keyboardHeight
              
              if textFieldBottomY > visibleHeight {
                  let offsetY = textFieldBottomY - visibleHeight - 10 // 添加 10 点的偏移量
                  scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
              }
          }
      }
      
    // 键盘隐藏时调用的方法
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -48), animated: true)
    }
    
    
    // MARK: - Gesture Selector
    @objc func dismissKeyboard() {
         view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: -48), animated: true)
     }
    
    // MARK: - Action Selector
    @IBAction func commandAction(_ sender: Any) {
        viewModel.selectedParticipationWay(.command)
    }
    @IBAction func moneyAction(_ sender: Any) {
        viewModel.selectedParticipationWay(.money)
    }
}

extension KTVLRSendRedPacketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? KTVLRSendRedPacketTextItemCell else {
            fatalError()
        }
        if collectionView == self.redPacketAmoutCollectionView {
            cell.label.text = viewModel.amoutString(at: indexPath.item, in: indexPath.section)
        } else if collectionView == self.redPacketSurvivalTimeCollectionView {
            cell.label.text = viewModel.timeString(at: indexPath.item, in: indexPath.section)
        } else {
            fatalError()
        }
        
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.redPacketAmoutCollectionView {
            return viewModel.numberOfAmountItems(in: section)
        } else if collectionView == self.redPacketSurvivalTimeCollectionView {
            return viewModel.numberOfTimeItems(in: section)
        } else {
            fatalError()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
    }
}

#Preview {
    let parentController = UIViewController()
    
    let controller = KTVLRSendRedPacketViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 620),
    ])
    return parentController;
}
