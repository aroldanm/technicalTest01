//
//  ProductDetailViewController.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var presenter: ProductDetailPresenter?

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageBlurred: UIImageView! {
        didSet {
            let effect = UIBlurEffect(style: .regular)
            let effectView = UIVisualEffectView(effect: effect)
            effectView.frame = imageBlurred.bounds
            effectView.autoresizingMask = [.flexibleWidth,
                                           .flexibleHeight]
            imageBlurred.addSubview(effectView)
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.minimumScaleFactor = 0.65
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.layer.shadowRadius = Constants.shadowRadius
            titleLabel.layer.shadowOffset = Constants.shadowOffset
            titleLabel.layer.shadowOpacity = Constants.shadowOpacity
        }
    }
    @IBOutlet private weak var genresLabel: UILabel! {
        didSet {
            genresLabel.layer.shadowRadius = Constants.shadowRadius
            genresLabel.layer.shadowOffset = Constants.shadowOffset
            genresLabel.layer.shadowOpacity = Constants.shadowOpacity
        }
    }
    @IBOutlet private weak var textView: UITextView! {
        didSet {
            textView.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        }
    }
    @IBOutlet private weak var ratingView: RatingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        updateTextView(text: textView.text,
                       userMode: newCollection.userInterfaceStyle)
    }
}

extension ProductDetailViewController: ProductDetailView {
}

private extension ProductDetailViewController {
    enum Constants {
        static let black = "black"
        static let white = "white"
        static let shadowRadius: CGFloat = 3
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowOpacity: Float = 0.4
    }

    func setupView() {
        guard let presenter = presenter else {
            return
        }
        let viewModel = presenter.loadData()
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        ratingView.update(with: viewModel.rating, tint: .systemPink)
        if let url = URL(string: viewModel.preview) {
            imageBlurred.load(from: url)
        }
        if let url = URL(string: viewModel.image) {
            imageView.load(from: url)
        }
        updateTextView(text: viewModel.summary,
                       userMode: UIScreen.main.traitCollection.userInterfaceStyle)
    }

    func updateTextView(text: String, userMode: UIUserInterfaceStyle) {
        let color = userMode == .dark ? Constants.white : Constants.black
        if let attributedString = htmlAttributed(from: text,
                                                 color: color) {
            textView.attributedText = attributedString
        }
    }

    func htmlAttributed(from text: String,
                        color: String? = Constants.black) -> NSAttributedString? {
        if let font = textView.font, let color = color {
            let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; color: \(color); font-size: \(font.pointSize)\">%@</span>", text)
            if let data = modifiedFont.data(using: .unicode, allowLossyConversion: true) {
                return try? NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            }
        }
        return nil
    }
}
