//
//  ProductDetailCollectionViewCell.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit
import Kingfisher

final class ProductDetailCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "ProductDetailCollectionViewCell"

    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initialization
    override private init(frame: CGRect) {
        super.init(frame: frame)
        arrangeViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Arrange Views
private extension ProductDetailCollectionViewCell {

    func arrangeViews() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - Populate UI
extension ProductDetailCollectionViewCell {

    func populateUI(with image: String) {
        let url = URL(string: image)
        imageView.kf.setImage(with: url)
    }
}
