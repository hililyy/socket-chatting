//
//  ConfirmVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

final class ConfirmVC: BaseVC {
    private let confirmView = ConfirmView()
    var confirmButtonTapHandler: () -> Void = {}
    
    override func loadView() {
        super.loadView()
        view = confirmView
        initalize()
    }
    
    func initalize() {
        initTarget()
    }
    
    func initTarget() {
        confirmView.confirmButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                dismissVC {
                    self.confirmButtonTapHandler()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func initUIText(messageText: String,
                    buttonText: String) {
        confirmView.setText(messageText: messageText,
                            buttonText: buttonText)
    }
}
