//
//  ItemsResponseModel.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import Foundation
import CoreData

// MARK: - WelcomeElement
struct ItemResponse: Codable {
    let description, id: String
    let image: String
    let imageList: [String]
    let price: String
    let productFeatures: ProductFeatures
    let title: String

    enum CodingKeys: String, CodingKey {
        case description, id, image, imageList, price
        case productFeatures = "product_features"
        case title
    }

    init(price: String, id: String, image: String, title: String) {
        self.price = price
        self.id = id
        self.image = image
        self.title = title

        self.description = ""
        self.imageList = [""]
        self.productFeatures = ProductFeatures(desen: Desen.desenli,
                                               kalıp: Kalıp.regular,
                                               kolTipi: KolTipi.kısaKol)
    }
}

// MARK: - ProductFeatures
struct ProductFeatures: Codable {
    let desen: Desen
    let kalıp: Kalıp
    let kolTipi: KolTipi

    enum CodingKeys: String, CodingKey {
        case desen = "Desen"
        case kalıp = "Kalıp"
        case kolTipi = "Kol Tipi"
    }
}

enum Desen: String, Codable {
    case desenli = "Desenli"
}

enum Kalıp: String, Codable {
    case regular = "Regular"
}

enum KolTipi: String, Codable {
    case kısaKol = "Kısa Kol"
}
