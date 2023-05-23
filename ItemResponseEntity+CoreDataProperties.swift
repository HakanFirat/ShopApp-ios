//
//  ItemResponseEntity+CoreDataProperties.swift
//  ShopApp
//
//  Created by Yunus İçmen on 9.05.2023.
//
//

import Foundation
import CoreData


extension ItemResponseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemResponseEntity> {
        return NSFetchRequest<ItemResponseEntity>(entityName: "ItemResponseEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var title: String?
    @NSManaged public var productCount: Int64

}

extension ItemResponseEntity : Identifiable {

}
