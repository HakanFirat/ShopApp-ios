//
//  HomeCollectionViewCell.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit
import Kingfisher

final class HomeCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "HomeCollectionViewCell"

    // MARK: - Properties
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .heavy)
        return label
    }()

    private(set) lazy var addToBasketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sepete ekle", for: .normal)
        button.backgroundColor = UIColor(hexString: "#FF33A2")
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }()

    // MARK: - Initialization
    override private init(frame: CGRect) {
        super.init(frame: frame)

        arrangeViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 4.0
        contentView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        productImageView.image = nil
        productImageView.kf.cancelDownloadTask()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Arrange Views
private extension HomeCollectionViewCell {

    func arrangeViews() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor

        [productImageView,
         productNameLabel,
         priceLabel,
         addToBasketButton].forEach({ contentView.addSubview($0) })

        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 280.0),

            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10.0),

            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10.0),

            addToBasketButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            addToBasketButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            addToBasketButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10.0),
            addToBasketButton.heightAnchor.constraint(equalToConstant: 45.0)
        ])
    }
}

// MARK: - Populate UI
extension HomeCollectionViewCell {

    func populateUI(with item: ItemResponse) {
        let url = URL(string: item.image)
        productImageView.kf.setImage(with: url)

        productNameLabel.text = item.title
        priceLabel.text = item.price + " TL"
    }
}
