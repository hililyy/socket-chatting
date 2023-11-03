//
//  FirebaseManager.swift
//  KakoBank
//
//  Created by 강조은 on 2023/10/11.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

final class FirebaseManager {
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

    func login(info: SignupModel, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: info.email, password: info.password) { _, error in
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
    
    func getNickname(newEmail: String = "") async throws -> String {
        let key = newEmail.isEmpty ? CommonManager.instance.newEmail : newEmail
        
        let (snapshot, _ ) = await Database.database().reference().child(key).child("nickname").observeSingleEventAndPreviousSiblingKey(of: .value)
        guard let nickname = snapshot.value as? String else { throw ErrorCase.invalidString }
        return nickname
    }
    
    func getProfileImage(newEmail: String = "") async throws -> URL {
        let key = newEmail.isEmpty ? CommonManager.instance.newEmail : newEmail
        
        let (snapshot, _ ) = await Database.database().reference().child(key).child("profile").observeSingleEventAndPreviousSiblingKey(of: .value)
        let imageUrlString = snapshot.value as? String
        guard let imageUrl = URL(string: imageUrlString ?? "") else { throw ErrorCase.invalidURL }
        return imageUrl
    }
    
    func saveNickNameAndProfileImage(socketId: String, nickname: String, image: UIImage, completion: @escaping (Bool) -> Void) {
        
        let newEmail = CommonManager.instance.newEmail
        let image = image.jpegData(compressionQuality: 0.1)
        let imageRef = Storage.storage().reference().child("profile").child(newEmail)
        
        imageRef.putData(image!, metadata: nil) { data, error in
            imageRef.downloadURL { url, error in
                guard let downloadURL = url else { return }
                Database.database().reference()
                    .child(newEmail)
                    .setValue(["nickname": nickname,
                               "profile": downloadURL.absoluteString]) { err, ref in
                        completion(err == nil)
                    }
            }
        }
    }
    
    func getProfileImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
}
