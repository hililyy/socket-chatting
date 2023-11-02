//
//  HomeView.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

class HomeView: BaseView {
    
    // MARK: - UI components
    
    let navigationView = NavigationView()
    
    lazy var colletionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(ChattingOnlineUserCVCell.self, forCellWithReuseIdentifier: "ChattingOnlineUserCVCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5.0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    let myProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 3
        view.layer.borderColor = Asset.Color.lightGrayClear.color.cgColor
        return view
    }()
    
    let myProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let myNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Pretendard.regular.font(size: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(ChattingRoomListTVCell.self, forCellReuseIdentifier: "ChattingRoomListTVCell")
        return tableView
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = .white
        navigationView.backButton.isHidden = true
        setNavigationTitle(title: "채팅방 목록")
    }
    
    // MARK: - Constraint
    
    func setNavigationTitle(title: String) {
        navigationView.setTitleLabelText(title: title)
    }
    
    func initAllFont() {
        navigationView.titleLabel.font = FontFamily.Pretendard.regular.font(size: 22)
        tableView.reloadData()
    }
    
    override func initSubviews() {
        addSubviews([navigationView, 
                     colletionView,
                     myProfileView,
                     tableView])
        myProfileView.addSubviews([myProfileImageView, myNicknameLabel])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        colletionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right)
            make.height.equalTo(100)
        }
        
        myProfileView.snp.makeConstraints { make in
            make.top.equalTo(colletionView.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-20)
        }
        
        myProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(myProfileView.snp.top).offset(20)
            make.left.equalTo(myProfileView.snp.left).offset(20)
            make.bottom.equalTo(myProfileView.snp.bottom).offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        myNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(myProfileView.snp.top).offset(10)
            make.left.equalTo(myProfileImageView.snp.right).offset(20)
            make.right.equalTo(myProfileView.snp.right).offset(-10)
            make.bottom.equalTo(myProfileView.snp.bottom).offset(-10)

        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(myProfileView.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
