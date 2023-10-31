//
//  BaseNC.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit

class BaseNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.isHidden = true
    }
}

extension BaseNC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
