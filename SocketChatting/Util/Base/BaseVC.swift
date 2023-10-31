//
//  BaseVC.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
    let disposeBag = DisposeBag()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
