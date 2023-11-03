//
//  ChattingRoomListTVCell.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

class ChattingRoomListTVCell: BaseTVCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Pretendard.medium.font(size: 18)
        return label
    }()
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    override func initSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    override func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
        }
    }
}
