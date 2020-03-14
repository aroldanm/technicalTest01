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
    func load(from stringUrl: String, placeholder: UIImage? = nil) -> URLSessionTask? {
        self.image = placeholder
        if let cached = loadImageFromCache(key: stringUrl) {
            self.image = cached
            return nil
        } else {
            guard let url = URL(string: stringUrl) else {
                return nil
            }
            return loadImageFromUrl(url) { image in
                if let image = image {
                    self.saveImageToCache(key: stringUrl, image: image)
                    self.setImage(image)
                }
            }
        }
    }
}

private extension UIImageView {

    func loadImageFromCache(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString) as? UIImage
    }

    func saveImageToCache(key: String, image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }

    func loadImageFromUrl(_ url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionTask {
        let task: URLSessionTask
        task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error == nil,
                let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }
        task.resume()
        return task
    }

    func setImage(_ image: UIImage, animated: Bool = true) {
        DispatchQueue.main.async {
            UIView.transition(with: self,
                              duration: animated ? 0.25 : 0.0,
                              options: .transitionCrossDissolve,
                              animations: {
                self.image = image
            }, completion: nil)
        }
    }
}
