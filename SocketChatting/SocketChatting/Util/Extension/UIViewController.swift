//
//  UIViewController.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

extension UIViewController {
    func popVC(isAnimated: Bool = true) {
        navigationController?.popViewController(animated: isAnimated)
    }
    
    func dismissVC(isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: isAnimated) {
            completion?()
        }
    }
    
    func registHomeToRoot() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(HomeNC())
    }
}
