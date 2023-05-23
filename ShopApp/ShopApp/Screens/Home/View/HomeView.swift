//
//  HomeView.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit
import SwiftUI

protocol HomeViewDelegate: AnyObject {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange textSearched: String)
    func navigateToProductDetail(with item: ItemResponse)
    func addToBasketButtonClicked(with item: ItemResponse)
}

final class HomeView: UIView {

    weak var delegate: HomeViewDelegate?

    //MARK: - Properties
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = "Marka, ürün veya hizmet arayın"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14.0,
                                                           weight: .regular)
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Marka, ürün veya hizmet arayın"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.keyboardType = .default
        searchBar.delegate = self
        return searchBar
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0.0, left: 12.0, bottom: 0.0, right: 12.0)
        layout.minimumInteritemSpacing = 10.0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeCollectionViewCell.cellIdentifier)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var items: [ItemResponse] = []

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
private extension HomeView {

    func arrangeViews() {
        backgroundColor = .white
        [searchBar, collectionView].forEach({ addSubview($0) })
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            searchBar.heightAnchor.constraint(equalToConstant: 40.0),

            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 36.0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Populate UI
extension HomeView {

    func populateUI(with items: [ItemResponse]) {
        self.items = items
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
}

extension HomeView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? HomeCollectionViewCell else { return .init() }
        cell.populateUI(with: items[indexPath.row])
        cell.addToBasketButton.addTapGestureRecognizer { [weak self] in
            guard let self = self else { return }
           self.delegate?.addToBasketButtonClicked(with: self.items[indexPath.row])
        }
        return cell
    }
}

extension HomeView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.navigateToProductDetail(with: items[indexPath.row])
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 420.0)
    }
}

extension HomeView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange textSearched: String) {
        delegate?.searchBar(searchBar, textDidChange: textSearched)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView().showPreview()
    }
}
