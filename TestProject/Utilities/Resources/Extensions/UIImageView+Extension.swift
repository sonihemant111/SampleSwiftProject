//
//  UIImage+ Extension.swift
//  TestProject
//
//  Created by Admin on 21/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    static func cacheImage(url: String) {
        guard let imageUrl = URL(string: url) else {return}
        
        if ImageCache.default.retrieveImageInMemoryCache(forKey: imageUrl.absoluteString) == nil {
            ImageDownloader.default.downloadImage(with: imageUrl, options: nil) { (result) in
                switch result {
                case .success(let value):
                    if let url = value.url {
                        ImageCache.default.store(value.image, forKey: (url.absoluteString))
                    }
                case .failure(_):
                    printDebug("Do Nothing")
                }
            }
        } else {
            printDebug("image is already cached")
        }
    }
}
