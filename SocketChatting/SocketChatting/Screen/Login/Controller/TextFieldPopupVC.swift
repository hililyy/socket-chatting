//
//  TextFieldPopupVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/03.
//

import UIKit
final class TextFieldPopupVC: BaseVC {
    
    // MARK: - Property
    
    let textFieldPopupView = TextFieldPopupView()
    weak var viewModel: HomeViewModel?
    var completeHandler: (String) -> () = { _ in }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = textFieldPopupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    // MARK: - Function
    
    private func complete() {
        guard let contents = textFieldPopupView.contentsTextView.text else { return }
        
        if !contents.isEmpty {
            dismissVC {
                self.completeHandler(contents)
//                self.viewModel?.setSuggestData(contents: contents)
//                self.viewModel?.getSuggestDatas()
            }
        }
    }
}

// MARK: - initalize

extension TextFieldPopupVC {
    private func initalize() {
        initTarget()
    }
    
    private func initTarget() {
        initBackgrounButtonTarget()
        initCompleteButtonTarget()
    }
    
    private func initBackgrounButtonTarget() {
        textFieldPopupView.backgroundButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCompleteButtonTarget() {
        textFieldPopupView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                complete()
            })
            .disposed(by: disposeBag)
    }
}
