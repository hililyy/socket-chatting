//
//  TextFieldPopupView.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/03.
//

import UIKit

final class TextFieldPopupView: BaseView {
    
    // MARK: - UI components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    lazy var backgroundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let contentsTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = FontFamily.Pretendard.regular.font(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Asset.Color.mainYellow.color.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        textView.becomeFirstResponder()
        return textView
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("만들기", for: .normal)
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
        button.titleLabel?.font = FontFamily.Pretendard.regular.font(size: 15)
        button.backgroundColor = Asset.Color.mainYellow.color
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Functions
    
    func setCompleteButtonEnable(_ isEnabled: Bool) {
        completeButton.isEnabled = isEnabled
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([backgroundView,
                     backgroundButton,
                     containerView])
        
        containerView.addSubviews([contentsTextView,
                                   completeButton])
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(60)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(180)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(30)
            make.left.equalTo(containerView.snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(contentsTextView.snp.bottom).offset(20)
            make.left.equalTo(contentsTextView.snp.left)
            make.bottom.equalTo(containerView.snp.bottom).offset(-25)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.equalTo(45)
        }
    }
}
