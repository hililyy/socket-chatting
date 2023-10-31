//
//  UIView.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview()})
    }
}
