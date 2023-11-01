//
//  OnboardingNameVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import Foundation

final class OnboardingNameVC: BaseVC {
    let onboardingNameView = OnboardingNameView()
    let viewModel = SignupViewModel()
    
    override func loadView() {
        view = onboardingNameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTarget()
    }
    
    func initTarget() {
        onboardingNameView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
        
        onboardingNameView.nextButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                viewModel.nickname = self.onboardingNameView.nicknameTextField.text ?? ""
                
                let vc = OnboardingImageVC()
                vc.viewModel = self.viewModel
                navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
