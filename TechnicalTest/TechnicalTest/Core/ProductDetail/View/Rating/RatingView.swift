//
//  RatingView.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 02/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class RatingView: UIView {
    @IBOutlet weak var label: EdgeInsetLabel! {
        didSet {
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 5
        }
    }
    @IBOutlet private var stars: [UIImageView]!
    
    func update(with rating: Double, tint: UIColor? = nil) {
        updateView(with: rating, tint: tint)
    }
}

private extension RatingView {
    enum Constants {
        static let star = "star"
        static let starFill = "star.fill"
        static let starMiddle = "star.lefthalf.fill"
    }

    func updateView(with value: Double, tint: UIColor?) {
        let ratingString = (String(format: "%.1f", value))
        let ratinFloat = Float(ratingString) ?? 0
        let mark = Int(ratinFloat)

        for i in 0 ... stars.count-1 {
            stars[i].image = UIImage(systemName: Constants.star)
            if i <= mark {
                if i == mark{
                    if ratinFloat > Float(mark) {
                        stars[i].image = UIImage(systemName: Constants.starMiddle)
                    }
                } else {
                    stars[i].image = UIImage(systemName: Constants.starFill)
                }
            }
            stars[i].tintColor = tint
        }

        label.text = ratingString
        label.backgroundColor = tint
    }
}
