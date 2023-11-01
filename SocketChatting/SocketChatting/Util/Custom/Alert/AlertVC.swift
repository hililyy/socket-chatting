//
//  AlertVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import Foundation

final class AlertVC: BaseVC {
    let alertView = AlertView()
    
    override func loadView() {
        super.loadView()
        view = alertView
        initalize()
    }
    
    private func initalize() {
        initTarget()
    }
    
    private func initTarget() {
        alertView.leftButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initUIText(messageText: String,
                    leftButtonText: String,
                    rightButtonText: String) {
        alertView.setText(messageText: messageText,
                          leftButtonText: leftButtonText,
                          rightButtonText: rightButtonText)
    }
}
