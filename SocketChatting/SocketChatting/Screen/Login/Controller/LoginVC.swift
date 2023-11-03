//
//  LoginVC.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginVC: BaseVC {
    let loginView = LoginView()
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    func initalize() {
        initTarget()
    }
    
    func initTarget() {
        loginView.signupButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                let vc = SignupVC()
                navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        loginView.loginButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                loginView.loading.startAnimating()
                login()
            })
            .disposed(by: disposeBag)
    }
    
    private func login() {
        guard let info = getLoginTextData() else { return }
        
        FirebaseManager.instance.login(info: info) { [weak self] message in
            guard let self else { return }
            loginView.loading.stopAnimating()
            
            if let message {
                presentConfirmVC(message: message)
            } else {
                CommonManager.instance.email = info.email.components(separatedBy: ["@","."]).joined()
                registHomeToRoot()
            }
        }
    }
    
    private func getLoginTextData() -> SignupModel? {
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else { return nil }
        
        return SignupModel(email: email,
                           password: password)
    }
    
    private func presentConfirmVC(message: String) {
        let vc = ConfirmVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.initUIText(messageText: message,
                      buttonText: "확인")
        present(vc, animated: true)
    }
}
