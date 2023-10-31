//
//  SignupVC.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit

class SignupVC: BaseVC {
    let signupView = SignupView()
    
    override func loadView() {
        super.loadView()
        view = signupView
    }
}
