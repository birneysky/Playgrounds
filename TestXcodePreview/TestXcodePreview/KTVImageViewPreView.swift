//
//  KTVImageViewPreView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/12.
//

import Foundation


#Preview("KTVImageView", traits: .portrait) {
    let view = KTVImageView(frame: CGRect(x: 0, y: 0, width: 260, height: 260))
    view.image = UIImage(named: "ktv_compete_red_packet_button")
    view.backgroundColor = .systemPink
    return view
}
