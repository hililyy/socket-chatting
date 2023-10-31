//
//  LoginView.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit
import SnapKit

class LoginView: BaseView {
    let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .white
        textField.placeholder = "아이디"
        textField.font = FontFamily.Pretendard.medium.font(size: 15)
        textField.addLeftPadding()
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .white
        textField.placeholder = "비밀번호"
        textField.font = FontFamily.Pretendard.medium.font(size: 15)
        textField.addLeftPadding()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = Asset.Color.darkGrayClear.color
        button.initButtonUI(text: "로그인",
                            font: FontFamily.Pretendard.medium.font(size: 15),
                            color: .darkGray)
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.initButtonUI(text: "회원가입",
                            font: FontFamily.Pretendard.medium.font(size: 13),
                            color: .darkGray)
        return button
    }()
    
    override func initUI() {
        backgroundColor = Asset.Color.mainYellow.color
    }
    
    override func initSubviews() {
        addSubviews([logoImageView,
                     emailTextField,
                     passwordTextField,
                     loginButton,
                     signupButton
                    ])
    }
    
    override func initConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(110)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(100)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(100)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
