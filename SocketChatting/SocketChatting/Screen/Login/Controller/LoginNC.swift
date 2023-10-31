//
//  LoginNC.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit

final class LoginNC: BaseNC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([LoginVC()], animated: true)
    }
}
