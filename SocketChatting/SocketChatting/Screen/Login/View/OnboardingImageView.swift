//
//  OnboardingImageView.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

class OnboardingImageView: BaseView {
    let navigationView = NavigationView()
    
    let profileImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
        button.imageView?.image = UIImage(systemName: "photo.badge.plus")
        button.imageView?.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.cornerRadius = 80
        button.backgroundColor = .white
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = Asset.Color.darkGrayClear.color
        button.initButtonUI(text: "완료",
                            font: FontFamily.Pretendard.medium.font(size: 15),
                            color: .darkGray)
        return button
    }()
    
    let loading = UIActivityIndicatorView()
    
    override func initUI() {
        navigationView.setTitleLabelText(title: "프로필 사진 등록")
        backgroundColor = Asset.Color.mainYellow.color
    }
    
    override func initSubviews() {
        addSubviews([navigationView,
                     profileImageButton,
                     nextButton,
                     loading])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(50)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(160)
            make.height.equalTo(160)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageButton.snp.bottom).offset(100)
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
        }
        
        loading.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
}
