//
//  BasketViewController.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit

final class BasketViewController: BaseViewController {

    // MARK: - Properties
    private lazy var deleteBasketButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Sepeti boşalt",
                                     style: .plain,
                                     target: self,
                                     action: #selector(deleteBasket))
        button.tintColor = .black
        return button
    }()

    private lazy var viewSource = BasketView()
    private let manager = CoreDataManager()

    // MARK: - Life Cycle
    override func loadView() {

        view = viewSource
        viewSource.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrangeViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewSource.populateUI(with: manager.fetch())
    }

    @objc func deleteBasket() {
        manager.deleteAllData {
            viewSource.populateUI(with: manager.fetch())
            viewSource.tableView.reloadData()
        }
    }
}

// MARK: - Arrange Views
private extension BasketViewController {
    
    func arrangeViews() {
        view.backgroundColor = .lightGray
        navigationItem.title = "Sepetim 3 ürün"

        navigationItem.rightBarButtonItem = deleteBasketButton
    }
}

extension BasketViewController: BasketViewDelegate {
    
    func reloadItem() {
        viewSource.populateUI(with: CoreDataManager().fetch())
    }

    func updateCount(item: ItemResponseEntity, count: Int) {
        guard count != 0 else {
            manager.delete(item: item) {
                let items = manager.fetch()
                viewSource.populateUI(with: items)
                guard items.count == .zero else { return  }
                navigationController?.popViewController(animated: true)
            }
            return
        }
        manager.update(id: item.id ?? "", count: count) {
            let items = manager.fetch()
            viewSource.populateUI(with: items)
        }
    }
}

