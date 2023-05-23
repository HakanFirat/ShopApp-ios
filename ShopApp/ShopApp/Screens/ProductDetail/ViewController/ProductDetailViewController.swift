//
//  ProductDetailViewController.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit

final class ProductDetailViewController: BaseViewController {

    // MARK: - Properties
    private lazy var basketButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "basketButton"), for: .normal)
        button.addTarget(self, action: #selector(navigateToBasket), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    
    private let productItem: ItemResponse

    private lazy var viewSource = ProductDetailView()

    // MARK: - Life Cycle
    init(item: ItemResponse) {
        productItem = item
        super.init(nibName: nil, bundle: nil)

        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view = viewSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        arrangeViews()
        viewSource.populateUI(with: productItem)
    }
}

// MARK: - Arrange Views
private extension ProductDetailViewController {

    func arrangeViews() {
        navigationItem.title = productItem.title
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = basketButton
    }
}

// MARK: - Helper Methods
private extension ProductDetailViewController {

    @objc func navigateToBasket() {
        let viewController = BasketViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
