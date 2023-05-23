//
//  NetworkManager.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()

    private init() { }

    func loadJson() -> [ItemResponse]? {
        if let url = Bundle.main.url(forResource: "itemsJson", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ItemResponse].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
