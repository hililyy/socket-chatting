//
//  CommonManager.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/02.
//

import Foundation

final class CommonManager {
    private init() {}
    
    private static var _instance: CommonManager?
    
    public static var instance: CommonManager {
        if _instance == nil {
            _instance = CommonManager()
        }
        return _instance!
    }
    
    var email: String = ""
}
