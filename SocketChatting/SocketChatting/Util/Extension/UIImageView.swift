//
//  UIImageView.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/11/02.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: URL, completion: @escaping (UIImage) -> Void) {
        let urlString = url.absoluteString
        ImageCache.default.retrieveImage(forKey: urlString) { result in
            switch result {
            case .success(let value):
                if let image = value.image {
                    self.image = image
                    completion(image)
                } else {
                    guard let url = URL(string: urlString) else { return }
                    self.kf.setImage(with: url)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
