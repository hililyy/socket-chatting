//
//  FirebaseAuthErrors.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import Foundation

enum FirebaseAuthErrors: Int {
    case ALREADY_SIGNUP = 17007
    case WRONG_EMAIL_FORMAT = 17008
    case MISMATCH_PASSWORD = 17009
    case NON_EXISTENT_USER = 17011
    case SHORT_PASSWORD = 17026
}
