//
//  ChattingOnlineUserCVCell.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

class ChattingOnlineUserCVCell: BaseCVCell {
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Pretendard.regular.font(size: 12)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let onlineColorView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.green.color
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    func setIsOnlineColor(isConnected: Bool) {
        onlineColorView.backgroundColor = isConnected ? Asset.Color.green.color : .red
    }
    
    override func initSubviews() {
        contentView.addSubviews([profileImageView, nicknameLabel, onlineColorView])
    }
    
    override func initConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left).offset(8)
            make.right.equalTo(contentView.snp.right).offset(-8)
            make.bottom.equalTo(nicknameLabel.snp.top).offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        onlineColorView.snp.makeConstraints { make in
            make.right.equalTo(profileImageView.snp.right).offset(0)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(0)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
