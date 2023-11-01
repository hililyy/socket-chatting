//
//  HomeVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit

class HomeVC: BaseVC {
    let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeView.colletionView.dequeueReusableCell(withReuseIdentifier: "ChattingOnlineUserCVCell", for: indexPath) as? ChattingOnlineUserCVCell else { return UICollectionViewCell() }
        
        cell.nicknameLabel.text = "닉네이이임"
        return cell
    }
}
