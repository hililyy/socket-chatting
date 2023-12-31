//
//  SignupView.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit
import RxSwift
import RxCocoa

final class SignupView: BaseView {
    let navigationView = NavigationView()
    
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
    
    let rePasswordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .white
        textField.placeholder = "비밀번호 확인"
        textField.font = FontFamily.Pretendard.medium.font(size: 15)
        textField.addLeftPadding()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let passwordMessageLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(text: "",
                          color: .red,
                          font: FontFamily.Pretendard.medium.font(size: 14))
        return label
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = Asset.Color.darkGrayClear.color
        button.initButtonUI(text: "회원가입",
                            font: FontFamily.Pretendard.medium.font(size: 15),
                            color: .darkGray)
        return button
    }()
    
    let loading = UIActivityIndicatorView()
    
    let disposeBag = DisposeBag()
    
    override func initUI() {
        backgroundColor = Asset.Color.mainYellow.color
        navigationView.setTitleLabelText(title: "회원가입")
    }
    
    override func initTarget() {
        rePasswordTextField.rx.text
            .map {
                if self.passwordTextField.text == $0 {
                    return ""
                } else {
                    self.passwordMessageLabel.textColor = .red
                    return "비밀번호가 일치하지 않습니다"
                }
            }
            .bind(to: passwordMessageLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func initSubviews() {
        addSubview(navigationView)
        
        addSubviews([emailTextField,
                     passwordTextField,
                     rePasswordTextField,
                     passwordMessageLabel,
                     signupButton,
                     loading])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(50)
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
        
        rePasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
        
        passwordMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(rePasswordTextField.snp.bottom).offset(10)
            make.left.equalTo(rePasswordTextField.snp.left).offset(15)
            make.height.equalTo(30)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordMessageLabel.snp.bottom).offset(100)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
        
        loading.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
}
