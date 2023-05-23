//
//  CoreDataManager.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import Foundation
import CoreData

final class CoreDataManager {

    private let persistentContainer: NSPersistentContainer
    private let entityName: String = "ItemResponseEntity"

    init() {
        persistentContainer = NSPersistentContainer(name: "ItemResponseEntity")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store Failed \(error.localizedDescription)")
            }
        }
    }

    func save(with item: ItemResponse, completion: () -> Void) {
        let context = persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                      in: context) else { return }
        let data = NSManagedObject(entity: entity,
                                   insertInto: context)

        data.setValue(item.id, forKey: "id")
        data.setValue(item.price, forKey: "price")
        data.setValue(item.image, forKey: "image")
        data.setValue(item.title, forKey: "title")
        data.setValue(0, forKey: "productCount")

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
        completion()
    }

    func fetch() -> [ItemResponseEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ItemResponseEntity> = ItemResponseEntity.fetchRequest()
        var savedData: [ItemResponseEntity] = []
        do {
            savedData = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return savedData
    }

    func deleteAllData(completion: () -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                persistentContainer.viewContext.delete(managedObjectData)
                completion()
            }
        } catch let error as NSError {
            print("Delete error: \(error.localizedDescription)")
        }
    }

    func delete(item: ItemResponseEntity, completion: () -> Void) {
        let objectToDelete = persistentContainer.viewContext.object(with: item.objectID)
        persistentContainer.viewContext.delete(objectToDelete)

        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("An error occurred while deleting: \(error)")
            }
        }
        completion()
    }

    func update(id: String, count: Int, completion: () -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else { return }
            if let container = result.first {
                container.setValue(count, forKey: "productCount")
                try context.save()
                context.refreshAllObjects()
                completion()
            }
        } catch {
            print("An error occurred while updating: \(error)")
        }
    }
}
