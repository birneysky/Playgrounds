//
//  KTVLRWinRedPacketViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/17.
//

import UIKit

@objc protocol KTVRoomRedPacketModel {
    @objc var identify: String { get }
    @objc var name: String { get }
    @objc var participants: [String] { get }
    @objc var countDown: Int { get }
    @objc var num: Int { get }
    @objc var participantsType: String { get }
    @objc var participantsText1: String { get }
    @objc var participantsText2: String { get }
    @objc var participantsText3: String { get }
    @objc var userName: String { get }
    @objc var userAvatar: String { get }
}

class KTVRoomRedPacketInfo: NSObject, KTVRoomRedPacketModel {
    var identify: String
    
    var name: String
    
    var participants: [String]
    
    var countDown: Int
    
    var num: Int
    
    var participantsType: String
    
    var participantsText1: String
    
    var participantsText2: String
    
    var participantsText3: String
    
    var userName: String
    
    var userAvatar: String
    
    
    init(identify: String, name: String, participants: [String], countDown: Int, num: Int, participantsType: String, participantsText1: String, participantsText2: String, participantsText3: String, userName: String, userAvatar: String) {
        self.identify = identify
        self.name = name
        self.participants = participants
        self.countDown = countDown
        self.num = num
        self.participantsType = participantsType
        self.participantsText1 = participantsText1
        self.participantsText2 = participantsText2
        self.participantsText3 = participantsText3
        self.userName = userName
        self.userAvatar = userAvatar
    }
    
}

class KTVLRWinRedPacketViewController: UIViewController {

    @IBOutlet weak var contentContainer: UIView!
    var viewModel = KTVLRWinRedPacketViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        bindViewModel()
        
        viewModel.setModel(KTVRoomRedPacketInfo(identify: "xxx", name: "200 钻石红包", participants: ["382109392183", "4382104"], countDown: 100, num: 20, participantsType: "word", participantsText1: "去评论", participantsText2: "抢红包", participantsText3: "发布评论 222", userName: "王大爷", userAvatar: "my_group"))
        
    }
    
    var competeRedPacketView: KTVLRCompeteRedPacketView {
        let view = KTVLRCompeteRedPacketView.view()
        view.tap = {[weak self] type in
            print("xxxx")
            self?.viewModel.xxx()
        }
        return view
    }

    func bindViewModel() {
        viewModel.state.bind {[weak self] state in
            guard let self = self, let state = state else { return }
            self.contentContainer.subviews.forEach { view in
                view.removeFromSuperview()
            }
            if state == .distributed {
                self.contentContainer.addSubview(self.competeRedPacketView)
            } else if state == .claiming {
                let view = KTVLRParticipatedRedPacketView.view()
                self.contentContainer.addSubview(view)
            }
        }
    }

    // MARK: - Action Selector
    @IBAction func closeAction(_ sender: Any) {
        self.view.isHidden  = true
    }
}


#Preview {
    let parentController = UIViewController()
    parentController.view.backgroundColor = .black
    let controller = KTVLRWinRedPacketViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.widthAnchor.constraint(equalToConstant: 243),
        controller.view.heightAnchor.constraint(equalToConstant: 391),
    ])
    return parentController;
}
