//
//  BasketTableViewCell.swift
//  ShopApp
//
//  Created by Yunus İçmen on 9.05.2023.
//

import UIKit
import Kingfisher

final class BasketTableViewCell: UITableViewCell {

    static let cellIdentitifer: String = "BasketTableViewCell"

    // MARK: - Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#839192")
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        return label
    }()

    private lazy var counterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12.0
        [decreaseButton,
         countLabel,
         increaseButton].forEach({ stackView.addArrangedSubview($0) })
        return stackView
    }()

    private(set) lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(hexString: "#FF6200EE"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24.0)
        button.contentVerticalAlignment = .top
        return button
    }()

    private(set) lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0)
        label.sizeToFit()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#839192")
        return label
    }()

    private(set) lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.contentVerticalAlignment = .top
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(hexString: "#FF6200EE"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24.0)
        return button
    }()

    var itemCount: Int = .zero {
        didSet {
            countLabel.text = String(itemCount)
        }
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        arrangeViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Overrides
extension BasketTableViewCell {

    // MARK: - Overrides
    override func prepareForReuse() {
        productImageView.image = nil
        productImageView.kf.cancelDownloadTask()
        productNameLabel.text = nil
    }
}

// MARK: - Arrange Views
private extension BasketTableViewCell {

    func arrangeViews() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        [productImageView,
         productNameLabel,
         priceLabel,
         counterStackView].forEach({ containerView.addSubview($0) })
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 12.0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -12.0),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 12.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: 12.0),

            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 148.0),
            productImageView.widthAnchor.constraint(equalToConstant: 148.0),

            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,
                                                      constant: 6.0),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor,
                                                  constant: 12.0),
            productNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                       constant: -12.0),

            priceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                 constant: -6.0),
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,
                                            constant: 6.0),

            counterStackView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            counterStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,
                                                  constant: 14.0),
            counterStackView.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}

// MARK: - Populate UI
extension BasketTableViewCell {

    func populateUI(with item: ItemResponseEntity) {
        let url = URL(string: item.image ?? "")
        productImageView.kf.setImage(with: url)
        productNameLabel.text = item.title
        priceLabel.text = (item.price ?? "") + " TL"
        countLabel.text = String(item.productCount == .zero ? 1 : item.productCount)
    }
}
