//
//  FirebaseAuthManager.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {
    private init() {}
    
    private static var _instance: FirebaseManager?
    
    public static var instance: FirebaseManager {
        if _instance == nil {
            _instance = FirebaseManager()
        }
        return _instance!
    }
    
    func signup(info: SignupModel, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: info.email, password: info.password) { _, error in
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case FirebaseAuthErrors.ALREADY_SIGNUP.rawValue:
                    completion("이미 가입한 회원")
                case FirebaseAuthErrors.WRONG_EMAIL_FORMAT.rawValue:
                    completion("이메일 형식 틀림")
                case FirebaseAuthErrors.SHORT_PASSWORD.rawValue:
                    completion("비밀번호 넘 짧음")
                default:
                    completion("회원가입 실패")
                }
            } else {
                completion(nil)
            }
        }
    }

    func login(email: String, pw: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pw) { _, error in
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case FirebaseAuthErrors.WRONG_EMAIL_FORMAT.rawValue:
                    completion("이메일 형식 틀림")
                case FirebaseAuthErrors.MISMATCH_PASSWORD.rawValue:
                    completion("비밀번호 틀림")
                case FirebaseAuthErrors.NON_EXISTENT_USER.rawValue:
                    completion("이미 존재하는 유저")
                default:
                    completion("로그인 실패")
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func signout(completion: @escaping (Bool) -> Void) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func getCurrentUserEmail() -> String {
        return Auth.auth().currentUser?.email ?? ""
    }
    
    func getUID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    func saveNickname(nickname: String) {
        let uid = getUID()
        Database.database().reference().child(uid).child("detail").childByAutoId().setValue(nickname)
    }
    
    func getNickname() {
        let uid = getUID()
        Database.database().reference().child(uid).child("nickname").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                print(snap)
//                guard let data = AllDiaryData.Detail(JSON: snap.value as! [String:AnyObject]) else { return }
//                MainModel.model.dateWithCircle.append(data.date ?? "")
//                MainModel.model.detailKey.append(snap.key)
//                MainModel.model.detailDiaryData.append(data)
            }
        }
    }
}
