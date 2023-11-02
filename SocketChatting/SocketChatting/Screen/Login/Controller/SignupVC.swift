//
//  SignupVC.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit

final class SignupVC: BaseVC {
    private let signupView = SignupView()
    let viewModel = SignupViewModel()
    
    override func loadView() {
        super.loadView()
        view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }

    private func signup() {
        guard let info = getSignupTextData() else { return }
        
        FirebaseManager.instance.signup(info: info) { message in
            self.presentConfirmVC(message: message)
            self.signupView.loading.stopAnimating()
        }
    }
    
    private func getSignupTextData() -> SignupModel? {
        guard let email = signupView.emailTextField.text,
              let password = signupView.passwordTextField.text else { return nil }
        
        return SignupModel(email: email,
                           password: password)
    }
    
    private func isCorrectInputPassword() -> Bool {
        return signupView.passwordTextField.text == signupView.rePasswordTextField.text
    }
    
    private func presentConfirmVC(message: String?) {
        let vc = ConfirmVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        
        let resultMessage = message == nil ? "회원가입이 완료되었습니다" : message!
        vc.initUIText(messageText: resultMessage,
                      buttonText: "확인")
        
        if message == nil {
            vc.confirmButtonTapHandler = {
                self.viewModel.email = self.signupView.emailTextField.text
                
                SocketIOManager.instance.connectToServerWithNickname(nickname: self.signupView.emailTextField.text ?? "") { userList in
                    
                    for user in userList {
                        if user["nickname"] as? String == self.signupView.emailTextField.text {
                            CommonManager.instance.socketId = user["socketId"] as? String ?? ""
                            CommonManager.instance.email = self.signupView.emailTextField.text ?? ""
                            let str = self.signupView.emailTextField.text ?? ""
                            CommonManager.instance.newEmail = str.components(separatedBy: ["@","."]).joined()
                            print(CommonManager.instance.newEmail)
                            return
                        }
                    }
                }
                
                let vc = OnboardingNameVC()
                vc.viewModel = self.viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        self.present(vc, animated: true)
    }
}

extension SignupVC {
    private func initalize() {
        initTarget()
    }
    
    private func initTarget() {
        signupView.signupButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                if isCorrectInputPassword() {
                    signupView.loading.startAnimating()
                    signup()
                } else {
                    presentConfirmVC(message: "비밀번호를 동일하게 입력해주세요")
                }
            })
            .disposed(by: disposeBag)
        
        signupView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
}
