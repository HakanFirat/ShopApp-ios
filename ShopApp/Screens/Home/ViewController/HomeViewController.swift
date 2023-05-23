//
//  HomeViewController.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = HomeView()

    private lazy var basketButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "basketButton"), for: .normal)
        button.addTarget(self, action: #selector(navigateToBasket), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()

    private var products = NetworkManager.shared.loadJson()
    private var searchedProducts = NetworkManager.shared.loadJson()

    private let manager = CoreDataManager()

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()

        arrangeViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let products = searchedProducts else { return }
        viewSource.populateUI(with: products)
    }
}

// MARK: - Arrange Views
private extension HomeViewController {
    
    func arrangeViews() {
        navigationItem.title = "Shop App"
        view = viewSource

        navigationItem.rightBarButtonItem = basketButton
        viewSource.delegate = self
    }
}

// MARK: - Helper Methods
private extension HomeViewController {

    @objc func navigateToBasket() {
        let viewController = BasketViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: HomeViewDelegate {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange textSearched: String) {

        guard !textSearched.isEmpty else {
            if let products = products {
                viewSource.populateUI(with: products)
            }
            return
        }

        guard let products = products, var searchProducts = searchedProducts else { return }
        searchProducts = products.filter({ (product) -> Bool in
            return (product.title.localizedCaseInsensitiveContains(String(textSearched)))
        })
    
        viewSource.populateUI(with: searchProducts)
    }

    func navigateToProductDetail(with item: ItemResponse) {
        let viewController = ProductDetailViewController(item: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func addToBasketButtonClicked(with item: ItemResponse) {
        manager.save(with: item) {
            let alert = UIAlertController(title: "",
                                          message: "Sepete Eklendi",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
             
        }
    }
}
