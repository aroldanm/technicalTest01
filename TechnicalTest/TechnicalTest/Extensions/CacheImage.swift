//
//  CacheImage.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func load(from stringUrl: String, placeholder: UIImage? = nil) {
        self.image = placeholder
        if let cached = imageCache.object(forKey: stringUrl as NSString) as? UIImage {
            self.image = cached
            return
        }
        if let url = URL(string: stringUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            imageCache.setObject(image, forKey: url.absoluteString as NSString)
                            UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
                                self.image = image
                            }, completion: nil)
                        }
                    }
                }
            }).resume()
        }
    }

    func cached(from stringUrl: String) {
        if let cached = imageCache.object(forKey: stringUrl as NSString) as? UIImage {
            self.image = cached
        }
    }
}
