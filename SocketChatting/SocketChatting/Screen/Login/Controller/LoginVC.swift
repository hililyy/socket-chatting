//
//  LoginVC.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: BaseVC {
    let loginView = LoginView()
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewDidLoad() {
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
    }
}
