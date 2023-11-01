//
//  BaseCVCell.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

class BaseCVCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initSubviews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {}
    func initSubviews() {}
    func initConstraints() {}
}
