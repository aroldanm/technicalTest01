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
    
    func update(with rating: Float, tint: UIColor? = nil) {
        let normalized = rating*5.0/10.0
        updateView(with: normalized, tint: tint)
    }
}

private extension RatingView {
    func updateView(with value: Float, tint: UIColor?) {
        let ratingString = (String(format: "%.1f", value))
        let ratinFloat = Float(ratingString) ?? 0
        let mark = Int(ratinFloat)
        for i in 0 ... stars.count-1 {
            stars[i].image = UIImage(systemName: "star")
            if i <= mark {
                if i == mark{
                    if ratinFloat > Float(mark) {
                    stars[i].image = UIImage(systemName: "star.lefthalf.fill")
                    }
                } else {
                    stars[i].image = UIImage(systemName: "star.fill")
                }
            }
            stars[i].tintColor = tint
        }

        label.text = ratingString
        label.backgroundColor = tint
    }
}
