//
//  BasketView.swift
//  ShopApp
//
//  Created by Yunus İçmen on 9.05.2023.
//

import UIKit

protocol BasketViewDelegate: AnyObject {

    func reloadItem()
    func updateCount(item: ItemResponseEntity, count: Int)
}

final class BasketView: UIView {

    //MARK: - Properties
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(BasketTableViewCell.self,
                           forCellReuseIdentifier: BasketTableViewCell.cellIdentitifer)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 160.0
        return tableView
    }()

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

    private lazy var approveBasketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sepeti Onayla", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6.0
        button.clipsToBounds = true
        button.backgroundColor = UIColor(hexString: "#3339FF")
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        return button
    }()

    private var items: [ItemResponseEntity] = []
    weak var delegate: BasketViewDelegate?

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
private extension BasketView {

    func arrangeViews() {
        backgroundColor = .white
        [tableView, bottomView].forEach({ addSubview($0) })

        [priceLabel, approveBasketButton].forEach({ bottomView.addSubview($0) })

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),

            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 60.0),
            bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor,
                                                constant: 24.0),
            priceLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(greaterThanOrEqualTo: approveBasketButton.leadingAnchor,
                                                 constant: 4.0),

            approveBasketButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,
                                                        constant: -24.0),
            approveBasketButton.heightAnchor.constraint(equalToConstant: 46.0),
            approveBasketButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            approveBasketButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
}

// MARK: - Populate UI
extension BasketView {

    func populateUI(with items: [ItemResponseEntity]) {
        self.items = items
        tableView.reloadData()
        for i in items {
            let productCount: Int = Int(i.productCount) > .zero ? Int(i.productCount) : 1
            priceLabel.text = String((Int(i.price ?? "") ?? 1) * productCount) + " TL"
        }
    }
}

extension BasketView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.cellIdentitifer,
                                                       for: indexPath) as? BasketTableViewCell else { return .init() }
        cell.populateUI(with: items[indexPath.row])
        cell.decreaseButton.addTapGestureRecognizer { [weak self] in
            guard let self = self else { return }
            if cell.itemCount != .zero {
                cell.itemCount -= 1
            }
            self.delegate?.updateCount(item: self.items[indexPath.row],
                                       count: cell.itemCount)
        }

        cell.increaseButton.addTapGestureRecognizer { [weak self] in
            guard let self = self, cell.itemCount <= 19  else { return }
            cell.itemCount += 1
            self.delegate?.updateCount(item: self.items[indexPath.row],
                                       count: cell.itemCount)
        }

        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
