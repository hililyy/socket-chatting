//
//  HomeViewModel.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/02.
//

import UIKit

final class HomeViewModel {
    var myInfo: UserModel = UserModel()
    var onlineUsers: [UserModel] = []
    
    func connectServer() async throws {
        SocketIOManager.instance.connectToServerWithNickname(nickname: CommonManager.instance.email) { userList in
            self.onlineUsers = []
            
            for user in userList {
                if user["nickname"] as? String == CommonManager.instance.email {
                    CommonManager.instance.socketId = user["socketId"] as? String ?? ""
                }
                if user["nickname"] as? String == "" { continue }
                
                self.onlineUsers.append(UserModel(email: user["nickname"] as? String,
                                                  socketId: user["socketId"] as? String,
                                                  isConnected: user["isConnected"] as? Bool))
            }
            return
        }
    }
    
    func getAllNicknameAndImage() async throws {
        for (i, user) in onlineUsers.enumerated() {
            let email = user.email?.components(separatedBy: ["@", "."]).joined() ?? ""
            let url = try await FirebaseManager.instance.getProfileImage(newEmail: email)
            let nickname = try await FirebaseManager.instance.getNickname(newEmail: email)
            self.onlineUsers[i].profileImageURL = url
            self.onlineUsers[i].nickname = nickname
        }
    }
}
