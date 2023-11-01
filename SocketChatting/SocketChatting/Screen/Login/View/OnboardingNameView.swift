//
//  OnboardingNameView.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

class OnboardingNameView: BaseView {
    let navigationView = NavigationView()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .white
        textField.placeholder = "닉네임"
        textField.font = FontFamily.Pretendard.medium.font(size: 15)
        textField.addLeftPadding()
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = Asset.Color.darkGrayClear.color
        button.initButtonUI(text: "다음",
                            font: FontFamily.Pretendard.medium.font(size: 15),
                            color: .darkGray)
        return button
    }()
    
    override func initUI() {
        navigationView.setTitleLabelText(title: "닉네임 입력")
        backgroundColor = Asset.Color.mainYellow.color
    }
    
    override func initSubviews() {
        addSubviews([navigationView,
                     nicknameTextField,
                     nextButton])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(50)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(100)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
    }
}
