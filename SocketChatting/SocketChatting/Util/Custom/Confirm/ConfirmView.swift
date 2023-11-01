//
//  ConfirmView.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

final class ConfirmView: BaseView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    private let contentsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Pretendard.regular.font(size: 18)
        label.text = "메시지 입니다아아아아아"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.initButtonUI(text: "확인",
                            font: FontFamily.Pretendard.regular.font(size: 18),
                            color: .black)
        button.backgroundColor = Asset.Color.mainYellow.color
        button.layer.cornerRadius = 20
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    func setText(messageText: String, buttonText: String) {
        messageLabel.text = messageText
        confirmButton.setTitle(buttonText, for: .normal)
    }
    
    override func initSubviews() {
        addSubviews([backgroundView,
                     contentsView
        ])
        contentsView.addSubviews([messageLabel,
                                  confirmButton
        ])
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        contentsView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(180)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(contentsView.snp.top)
            make.left.equalTo(contentsView.snp.left)
            make.right.equalTo(contentsView.snp.right)
            make.bottom.equalTo(confirmButton.snp.top)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.left.equalTo(contentsView.snp.left)
            make.right.equalTo(contentsView.snp.right)
            make.bottom.equalTo(contentsView.snp.bottom)
            make.height.equalTo(70)
        }
    }
}
