//
//  OnboardingImageVC.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/01.
//

import UIKit
import Photos

final class OnboardingImageVC: BaseVC {
    let onboardingImageView = OnboardingImageView()
    let imagePicker = UIImagePickerController()
    var viewModel: SignupViewModel?

    override func loadView() {
        view = onboardingImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTarget()
        imagePicker.delegate = self
    }
    
    func initTarget() {
        onboardingImageView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
        
        onboardingImageView.nextButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                onboardingImageView.loading.startAnimating()
                FirebaseManager.instance.saveNickNameAndProfileImage(nickname: viewModel?.nickname ?? "",
                                                                     image: self.viewModel?.profileImage ?? .icBack,
                                                                     completion: { result in
                    
                    if result {
                        self.onboardingImageView.loading.stopAnimating()
                        self.registHomeToRoot()
                    } else {
                        self.presentConfirmVC(message: "퐈이어베이스 오류발생!!!")
                    }
                })
            })
            .disposed(by: disposeBag)
        
        onboardingImageView.profileImageButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                albumAuth()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentConfirmVC(message: String?) {
        let vc = ConfirmVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.initUIText(messageText: message ?? "에러러렁어어어어어!!!!!!!",
                      buttonText: "확인")
        self.present(vc, animated: true)
    }
    
    private func openPhotoLibrary() {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) { 
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.modalPresentationStyle = .currentContext
                self.present(self.imagePicker, animated: true)
            } else {
                self.presentConfirmVC(message: "앨범에 접근할 수 없습니다.")
            }
        }
    }
    
    private func albumAuth() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .denied:
            self.presentConfirmVC(message: "앨범")
            
        case .authorized:
            self.openPhotoLibrary()
            
        case .notDetermined, .restricted:
            PHPhotoLibrary.requestAuthorization { state in
                if state == .authorized {
                    self.openPhotoLibrary()
                } else {
                    self.dismiss(animated: true)
                }
            }
            
        default:
            break
        }
    }
}

extension OnboardingImageVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            onboardingImageView.profileImageButton.setImage(image, for: .normal)
            viewModel?.profileImage = image
        }
        
        dismiss(animated: true)
    }
}
