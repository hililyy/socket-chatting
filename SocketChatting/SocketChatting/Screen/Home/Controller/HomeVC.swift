//
//  HomeVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit
import Kingfisher

class HomeVC: BaseVC {
    let homeView = HomeView()
    let viewModel = HomeViewModel()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.homeView.colletionView.reloadData()
        }
    }
    
    func initUI() {
        self.viewModel.connectServer {
            
            FirebaseManager.instance.getProfileImage { url in
                print("url:\(url)")
                self.homeView.myProfileImageView.setImage(url: url) { image in
                    self.viewModel.myInfo.profileImageURL = url
                }
                FirebaseManager.instance.getNickname { nickname in
                    self.homeView.myNicknameLabel.text = nickname
                    self.viewModel.myInfo.nickname = nickname
                    
                    self.viewModel.getAllNickname {
                        self.viewModel.getAllProfileImage {
                            self.homeView.colletionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func initDelegate() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.colletionView.delegate = self
        homeView.colletionView.dataSource = self
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeView.tableView.dequeueReusableCell(withIdentifier: "ChattingRoomListTVCell", for: indexPath) as? ChattingRoomListTVCell else { return UITableViewCell() }
        
        cell.titleLabel.text = "제목"
        cell.messageLabel.text = "메시지"
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
