//
//  KTVLRSendRedPacketViewController.swift
//  ktv
//
//  Created by Bruce on 2024/6/13.
//

import UIKit

class KTVLRSendRedPacketViewController: UIViewController {

    @IBOutlet weak var roundedView: KTVPartialRoundedView!
    @IBOutlet weak var numTextField: UITextField!
    @IBOutlet weak var commandTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var participationCollectionView: UICollectionView!
    @IBOutlet weak var survivalTimeCollectionView: UICollectionView!
    @IBOutlet weak var amoutCollectionView: UICollectionView!
    @IBOutlet weak var amountCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commandTextFieldContainer: UIStackView!
    private let reuseIdentifier = "KTVLRSendRedPacketTextItemCell"
    @IBOutlet weak var participationCollectionHeightConstraint: NSLayoutConstraint!
    var isScrolling = false
    var viewModel = KTVLRSendRedPacketViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let maxHeight:CGFloat = 538;
//        self.view.height = maxHeight;
//        self.view.width = UIScreen.main.bounds.size.width
        self.view.backgroundColor = .clear
        self.roundedView.corners = [.topLeft, .topRight]

        registerCollectionCell()
        registNotification()
        addGesture()
        bindViewModel()
        
        viewModel.getData()
    }
    
    override func loadView() {
        super.loadView()
        roundedView.corners = [.topLeft, .topRight]
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
        amoutCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        survivalTimeCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        participationCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
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
        label.textColor = rgba("#FF334899")
        label.textAlignment = .center
        rightView.addSubview(label)
        numTextField.rightViewMode = .always
        numTextField.rightView = rightView
        numTextField.layer.cornerRadius = 14
        numTextField.layer.borderColor = rgba("#FF3348FF").cgColor
        numTextField.layer.borderWidth = 0.5
        numTextField.layer.masksToBounds = true
        
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
                self.amoutCollectionView.reloadData()
                self.amoutCollectionView.layoutIfNeeded()
                self.amountCollectionHeightConstraint.constant = self.amoutCollectionView.contentSize.height
                
                self.survivalTimeCollectionView.reloadData()
                self.survivalTimeCollectionView.layoutIfNeeded()
                self.timeCollectionHeightConstraint.constant = self.survivalTimeCollectionView.contentSize.height
                
                
                self.participationCollectionView.reloadData()
                self.participationCollectionView.layoutIfNeeded()
                self.participationCollectionHeightConstraint.constant = self.survivalTimeCollectionView.contentSize.height
                
                self.view.layoutIfNeeded()
            }
        }
        viewModel.amountIndex.bind {[weak self] index in
            guard let self = self, let index = index else {
                return
            }
            self.amoutCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .left)
        }
        viewModel.timeSelectIndex.bind {[weak self] index in
            guard let self = self, let index = index else {
                return
            }
            self.survivalTimeCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .left)
        }
        
        viewModel.selectedParticipationIndex.bind { [weak self] index in
            guard let self = self, let index = index else {
                return
            }
            self.participationCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .left)
        }
        
        viewModel.selectedParticipationType.bind {[weak self] type  in
            guard let self = self, let type = type else {
                return
            }
            if type == .command {
                self.commandTextFieldContainer.isHidden = false
            } else {
                self.commandTextFieldContainer.isHidden = true
            }
            
        }
    }
    
    // MARK: - Notification Selector
    @objc func keyboardWillShow(notification: NSNotification) {
        if numTextField.isFirstResponder { return }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let commandTextFieldContainer = commandTextField.superview {
              let keyboardHeight = keyboardSize.height
              let textFieldFrame = commandTextFieldContainer.convert(commandTextFieldContainer.bounds, to: view)
              let textFieldBottomY = textFieldFrame.origin.y + textFieldFrame.height
              let visibleHeight = view.frame.height - keyboardHeight
              
              if textFieldBottomY > visibleHeight {
                  let offsetY = textFieldBottomY - visibleHeight
                  scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
              }
          }
      }
      
    @objc func keyboardWillHide(notification: NSNotification) {
        if !isScrolling {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    
    // MARK: - Gesture Selector
    @objc func dismissKeyboard() {
         view.endEditing(true)
     }
}

// MARK: - UICollectionViewDataSource
extension KTVLRSendRedPacketViewController: UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? KTVLRSendRedPacketTextItemCell else {
            fatalError()
        }
        if collectionView == amoutCollectionView {
            cell.label.text = viewModel.amoutString(at: indexPath.item, in: indexPath.section)
        } else if collectionView == survivalTimeCollectionView {
            cell.label.text = viewModel.timeString(at: indexPath.item, in: indexPath.section)
        } else if collectionView == participationCollectionView {
            cell.label.text = viewModel.participationString(at: indexPath.item, in: indexPath.section)
        }
        else {
            fatalError()
        }
        
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.amoutCollectionView {
            return viewModel.numberOfAmountItems(in: section)
        } else if collectionView == survivalTimeCollectionView {
            return viewModel.numberOfTimeItems(in: section)
        } else if collectionView == participationCollectionView {
            return viewModel.numberOfparticipationItems(in: section)
        }
        else {
            fatalError()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    

}

// MARK: - UICollectionViewDataSource
extension KTVLRSendRedPacketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        if collectionView == amoutCollectionView {
            viewModel.selectAmount(at: indexPath.item, in: indexPath.section)
            survivalTimeCollectionView.reloadData()
            participationCollectionView.reloadData()
        } else if collectionView == participationCollectionView {
            viewModel.selectedParticipationWay(at: indexPath.item, in: indexPath.section)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension KTVLRSendRedPacketViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         isScrolling = true
        view.endEditing(true)
     }
     
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         if !decelerate {
             isScrolling = false
         }
     }
     
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         isScrolling = false
         //scrollView.setContentOffset(CGPoint(x: 0, y:), animated: true)
     }
}

// MARK: - UITextFieldDelegate
extension KTVLRSendRedPacketViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          // 获取当前 textField 的内容
          let currentText = textField.text ?? ""
          
          // 创建新的字符串
          guard let stringRange = Range(range, in: currentText) else { return false }
          let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
          
          // 检查新的字符串是否为空
          if updatedText.isEmpty {
              return true
          }
          
          // 检查新的字符串是否是有效的数字
        if let range = viewModel.selectedNumRange,
           let newValue = Int(updatedText),
           newValue >= range.lowerBound,
            newValue <= range.upperBound {
              return true
          }
          
          // 如果不符合条件，返回 false
          return false
      }
}


@available(iOS 17.0, *)
#Preview{
    let parentController = UIViewController()
    let controller = KTVLRSendRedPacketViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor),
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 539),
    ])
    return parentController;
}
