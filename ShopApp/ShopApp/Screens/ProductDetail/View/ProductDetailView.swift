//
//  ProductDetailView.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit
import SwiftUI

final class ProductDetailView: UIView {

    //MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 400.0)
        layout.minimumLineSpacing = .zero
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductDetailCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductDetailCollectionViewCell.cellIdentifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor(hexString: "#80839192")
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        return pageControl
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var productNameDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        return view
    }()

    private lazy var productDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12.0
        [productDescriptionTitleLabel,
         productDescriptionLabel].forEach({ stackView.addArrangedSubview($0) })
        return stackView
    }()

    private lazy var productDescriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ürün Açıklaması"
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13.0, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var productDescriptionDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        return view
    }()

    private lazy var productPropertiesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ürün Özellikleri"
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var productPropertiesContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var desingContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6.0
        [desingStackView,
         designDividerView].forEach({ stackView.addArrangedSubview($0) })
        return stackView
    }()

    private lazy var designDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        return view
    }()

    private lazy var desingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        [designTitleLabel,
         designDescriptionLabel].forEach({ stackView.addArrangedSubview($0) })
        return stackView
    }()

    private lazy var designTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Desen"
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#839192")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var designDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#839192")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()

    private lazy var patternContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6.0
        [patternStackView,
         patternDividerView].forEach({ stackView.addArrangedSubview($0) })
        return stackView
    }()

    private lazy var patternDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        return view
    }()

    private lazy var patternStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        [patternTitleLabel,
         patternDescriptionLabel].forEach({ stackView.addArrangedSubview($0) })
        return stackView
    }()

    private lazy var patternTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kalıp"
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#839192")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var patternDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#839192")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()

    private lazy var armTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        [armTypeTitleLabel,
         armTypeDescriptionLabel].forEach({ stackView.addArrangedSubview($0) })
        return stackView
    }()

    private lazy var armTypeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kol Tipi"
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#839192")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    private lazy var armTypeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#839192")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()

    // MARK: - including priceLabel&addToBasket button
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24.0)
        label.sizeToFit()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#3339FF")
        return label
    }()

    private lazy var addToBasketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6.0
        button.clipsToBounds = true
        button.backgroundColor = UIColor(hexString: "#3339FF")
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        return button
    }()

    private var product: ItemResponse?
    private var images: [String] = []

    private let screenWidth = UIScreen.main.bounds.width

    //MARK: - initialization
    init() {
        super.init(frame: .zero)

        arrangeViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Arrange Views
private extension ProductDetailView {

    func arrangeViews() {
        [scrollView, bottomView].forEach({ addSubview($0) })
        [collectionView,
         pageControl,
         productNameLabel,
         productNameDividerView,
         productDescriptionStackView,
         productDescriptionDividerView,
         productPropertiesTitleLabel,
         productPropertiesContainerView].forEach({ scrollView.addSubview($0) })

        [desingContainerStackView,
         patternContainerStackView,
         armTypeStackView].forEach({ productPropertiesContainerView.addSubview($0) })

        [priceLabel, addToBasketButton].forEach({ bottomView.addSubview($0) })

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomView.topAnchor,
                                               constant: -6.0),

            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 60.0),
            bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor,
                                                constant: 24.0),
            priceLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(greaterThanOrEqualTo: addToBasketButton.leadingAnchor,
                                                 constant: 4.0),

            addToBasketButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,
                                                        constant: -24.0),
            addToBasketButton.heightAnchor.constraint(equalToConstant: 46.0),
            addToBasketButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            addToBasketButton.widthAnchor.constraint(equalToConstant: screenWidth / 2),

            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: screenWidth),
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400.0),

            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor,
                                             constant: 6.0),

            productNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                      constant: 24.0),
            productNameLabel.widthAnchor.constraint(equalToConstant: (screenWidth - 48.0)),

            productNameLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor,
                                                  constant: 24.0),

            productNameDividerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            productNameDividerView.widthAnchor.constraint(equalToConstant: screenWidth),
            productNameDividerView.heightAnchor.constraint(equalToConstant: 1.0),
            productNameDividerView.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,
                                                        constant: 12.0),

            productDescriptionStackView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productDescriptionStackView.widthAnchor.constraint(equalToConstant: screenWidth - 48.0),
            productDescriptionStackView.topAnchor.constraint(equalTo: productNameDividerView.bottomAnchor,
                                                             constant: 24.0),

            productDescriptionDividerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            productDescriptionDividerView.widthAnchor.constraint(equalToConstant: screenWidth),
            productDescriptionDividerView.heightAnchor.constraint(equalToConstant: 1.0),
            productDescriptionDividerView.topAnchor.constraint(equalTo: productDescriptionStackView.bottomAnchor,
                                                               constant: 24.0),

            productPropertiesTitleLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productPropertiesTitleLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            productPropertiesTitleLabel.topAnchor.constraint(equalTo: productDescriptionDividerView.bottomAnchor,
                                                             constant: 24.0),

            productPropertiesContainerView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productPropertiesContainerView.widthAnchor.constraint(equalToConstant: screenWidth - 48.0),
            productPropertiesContainerView.topAnchor.constraint(equalTo: productPropertiesTitleLabel.bottomAnchor,
                                                                constant: 24.0),
            productPropertiesContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            desingContainerStackView.leadingAnchor.constraint(equalTo: productPropertiesContainerView.leadingAnchor),
            desingContainerStackView.trailingAnchor.constraint(equalTo: productPropertiesContainerView.trailingAnchor),
            desingContainerStackView.topAnchor.constraint(equalTo: productPropertiesContainerView.topAnchor),

            patternStackView.leadingAnchor.constraint(equalTo: desingContainerStackView.leadingAnchor),
            patternStackView.trailingAnchor.constraint(equalTo: desingContainerStackView.trailingAnchor),
            patternStackView.topAnchor.constraint(equalTo: designDividerView.bottomAnchor,
                                                  constant: 12.0),

            armTypeStackView.leadingAnchor.constraint(equalTo: desingContainerStackView.leadingAnchor),
            armTypeStackView.trailingAnchor.constraint(equalTo: desingContainerStackView.trailingAnchor),
            armTypeStackView.topAnchor.constraint(equalTo: patternDividerView.bottomAnchor,
                                                  constant: 12.0),
            armTypeStackView.bottomAnchor.constraint(equalTo: productPropertiesContainerView.bottomAnchor)
        ])
    }
}

// MARK: - Populate UI
extension ProductDetailView {

    func populateUI(with item: ItemResponse) {
        product = item
        images = item.imageList
        pageControl.numberOfPages = item.imageList.count

        collectionView.reloadData()

        productNameLabel.text = item.title
        productDescriptionLabel.text = item.description
        designDescriptionLabel.text = item.productFeatures.desen.rawValue
        patternDescriptionLabel.text = item.productFeatures.kalıp.rawValue
        armTypeDescriptionLabel.text = item.productFeatures.kolTipi.rawValue
        priceLabel.text = item.price + " TL"
    }
}

extension ProductDetailView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? ProductDetailCollectionViewCell else { return .init() }
        cell.populateUI(with: images[indexPath.row])
        return cell
    }    
}

extension ProductDetailView: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
}

struct Hakan_Preview: PreviewProvider {
    static var previews: some View {
        ProductDetailView().showPreview()
    }
}
