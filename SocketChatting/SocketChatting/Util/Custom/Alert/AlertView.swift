//
//  AlertView.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

final class AlertView: BaseView {
    
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
    
    private let messageView = UIView()
    private let buttonView = UIView()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Pretendard.regular.font(size: 18)
        label.text = "메시지 입니다아아아아아"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.initButtonUI(text: "취소",
                            font: FontFamily.Pretendard.regular.font(size: 18),
                            color: .black)
        button.backgroundColor = Asset.Color.gray2.color
        button.layer.cornerRadius = 20
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.initButtonUI(text: "확인",
                            font: FontFamily.Pretendard.regular.font(size: 18),
                            color: .black)
        button.backgroundColor = Asset.Color.mainYellow.color
        button.layer.cornerRadius = 25
        button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        return button
    }()
    
    func setText(messageText: String, leftButtonText: String, rightButtonText: String) {
        messageLabel.text = messageText
        leftButton.setTitle(leftButtonText, for: .normal)
        rightButton.setTitle(rightButtonText, for: .normal)
    }
    
    override func initSubviews() {
        addSubviews([backgroundView,
                     contentsView
        ])
        contentsView.addSubviews([messageView,
                                  buttonView
        ])
        messageView.addSubview(messageLabel)
        buttonView.addSubviews([leftButton,
                                rightButton
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
        
        messageView.snp.makeConstraints { make in
            make.top.equalTo(contentsView.snp.top)
            make.left.equalTo(contentsView.snp.left)
            make.right.equalTo(contentsView.snp.right)
            make.bottom.equalTo(buttonView.snp.top)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalTo(messageView)
        }
        
        buttonView.snp.makeConstraints { make in
            make.left.equalTo(contentsView.snp.left)
            make.right.equalTo(contentsView.snp.right)
            make.bottom.equalTo(contentsView.snp.bottom)
            make.height.equalTo(70)
        }
        
        leftButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.left.equalTo(buttonView.snp.left)
            make.right.equalTo(rightButton.snp.left)
            make.bottom.equalTo(buttonView.snp.bottom)
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.right.equalTo(buttonView.snp.right)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.width.equalTo(leftButton.snp.width).multipliedBy(1.5)
            make.height.equalTo(leftButton.snp.height)
        }
    }
}
