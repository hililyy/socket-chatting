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
        return collectionView
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5.0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.itemSize = CGSize(width: 40, height: 40)
        return layout
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
        addSubviews([navigationView, colletionView, tableView])
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
            make.bottom.equalTo(tableView.snp.top).offset(-20)
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
