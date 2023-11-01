//
//  HomeNC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

final class HomeNC: BaseNC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([HomeVC()], animated: true)
    }
}
