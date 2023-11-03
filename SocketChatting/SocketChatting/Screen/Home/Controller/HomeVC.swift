//
//  HomeVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit
import Kingfisher

final class HomeVC: BaseVC {
    let homeView = HomeView()
    let viewModel = HomeViewModel()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        Task {
            try await initUI()
        }
        initTarget()
    }
    
    private func initUI() async throws {
        try await viewModel.connectServer()
        
        let url = try await FirebaseManager.instance.getProfileImage(email: CommonManager.instance.email)
        homeView.myProfileImageView.setImage(url: url) { image in
            self.viewModel.myInfo.profileImageURL = url
        }
        
        let nickname = try await FirebaseManager.instance.getNickname(email: CommonManager.instance.email)
        homeView.myNicknameLabel.text = nickname
        viewModel.myInfo.nickname = nickname
        try await viewModel.getAllNicknameAndImage()
        homeView.colletionView.reloadData()
    }
    
    private func initDelegate() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.colletionView.delegate = self
        homeView.colletionView.dataSource = self
    }
    
    private func initTarget() {
        homeView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: {
                SocketIOManager.instance.exitChatWithNickname(nickname: CommonManager.instance.email) {
                    DispatchQueue.main.async {
//                        self.users.removeAll()
//                        self.tblUserList.isHidden = true
//                        self.askForNickname()
                    }
                    self.popVC()
                }
            })
            .disposed(by: disposeBag)
        
        homeView.navigationView.rightBarButton.rx.tap
            .asDriver()
            .drive(onNext: {
                print("!!")
                let vc = TextFieldPopupVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.completeHandler = { roomTitle in
                    
                    
                }
                self.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeView.tableView.dequeueReusableCell(withIdentifier: "ChattingRoomListTVCell", for: indexPath) as? ChattingRoomListTVCell else { return UITableViewCell() }
        
        cell.titleLabel.text = "제목"
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.onlineUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeView.colletionView.dequeueReusableCell(withReuseIdentifier: "ChattingOnlineUserCVCell", for: indexPath) as? ChattingOnlineUserCVCell else { return UICollectionViewCell() }
        cell.nicknameLabel.text = viewModel.onlineUsers[indexPath.row].nickname
        if let url = viewModel.onlineUsers[indexPath.row].profileImageURL {
            cell.profileImageView.setImage(url: url, completion: {_ in })
        }
        cell.setIsOnlineColor(isConnected: viewModel.onlineUsers[indexPath.row].isConnected ?? false)
        return cell
    }
}
