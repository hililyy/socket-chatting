//
//  HomeViewModel.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/02.
//

import UIKit

class HomeViewModel {
    var myInfo: UserModel = UserModel()
    var onlineUsers: [UserModel] = []
    
    func connectServer(completion: @escaping () -> Void) {
        SocketIOManager.instance.connectToServerWithNickname(nickname: CommonManager.instance.email) { userList in
            print("이메일!!!!:\(CommonManager.instance.email)")
            self.onlineUsers = []
            for user in userList {
                var newData = UserModel()
                let socketId = (user["socketId"] as? String) ?? ""
                if user["nickname"] as? String == CommonManager.instance.email {
                    CommonManager.instance.socketId = user["socketId"] as? String ?? ""
                }
                self.onlineUsers.append(UserModel(email: user["nickname"] as? String,
                                                  socketId: user["socketId"] as? String,
                                                  isConnected: user["isConnected"] as? Bool))
            }
            completion()
        }
    }
    
    func getAllProfileImage(completion: @escaping () -> ()) {
        for (i, user) in onlineUsers.enumerated() {
            self.getProfileImage(newEmail: user.email?.components(separatedBy: ["@","."]).joined() ?? "") { url in
                self.onlineUsers[i].profileImageURL = url
            }
        }
        completion()
    }
    
    func getAllNickname(completion: @escaping () -> ()) {
        for (i, user) in onlineUsers.enumerated() {
            self.getNickname(newEmail: user.email?.components(separatedBy: ["@","."]).joined() ?? "") { nickname in
                print("?: \(nickname)")
                self.onlineUsers[i].nickname = nickname
            }
        }
        completion()
    }
    
    func getProfileImage(newEmail: String, completion: @escaping (URL) -> Void) {
        FirebaseManager.instance.getProfileImage(newEmail: newEmail) { url in
            completion(url)
        }
    }
    
    func getNickname(newEmail: String, completion: @escaping (String) -> Void) {
        FirebaseManager.instance.getNickname(newEmail: newEmail) { nickname in
            completion(nickname)
        }
    }
}
