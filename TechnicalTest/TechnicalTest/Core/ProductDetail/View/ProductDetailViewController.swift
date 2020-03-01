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
        }
    }
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var textView: UITextView! {
        didSet {
            textView.textContainerInset = UIEdgeInsets(top: 0, left: 12, bottom: 20, right: 12)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
}

private extension ProductDetailViewController {
    func setupView() {
        guard let presenter = presenter else {
            return
        }
        let viewModel = presenter.loadData()
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        
        if let attributedString = htmlAttributed(from: viewModel.summary) {
            textView.attributedText = attributedString
        }
        if let url = URL(string: viewModel.preview) {
            imageBlurred.load(from: url)
        }
        if let url = URL(string: viewModel.image) {
            imageView.load(from: url)
        }
    }

    func htmlAttributed(from text: String) -> NSAttributedString? {
        if let font = textView.font {
            let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(font.pointSize)\">%@</span>", text)
            if let data = modifiedFont.data(using: .unicode, allowLossyConversion: true) {
                return try? NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            }
        }
        return nil
    }
}
