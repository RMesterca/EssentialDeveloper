//
//  CoreDataStorageContext.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStorageContext  {

    var managedContext: NSManagedObjectContext?

    required init(configuration: ConfigurationType = .basic(identifier: "Mooskine")) {
        switch configuration {
        case .basic:
            initDB(modelName: configuration.identifier(), storeType: .sqLiteStoreType)
        case .inMemory:
            initDB(storeType: .inMemoryStoreType)
        }
    }

    private func initDB(modelName: String? = nil, storeType: StoreType) {
        let coordinator = CoreDataStoreCoordinator.persistentStoreCoordinator(modelName: modelName, storeType: storeType)
        self.managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.managedContext?.persistentStoreCoordinator = coordinator
    }

    func objectWithObjectId<DBEntity: Storable>(objectId: NSManagedObjectID) -> DBEntity? {
        do {
            let result = try managedContext!.existingObject(with: objectId)
            return result as? DBEntity
        } catch {
            assertionFailure("Failure")
        }

        return nil
    }
}

// MARK: StorageContext
extension CoreDataStorageContext: StorageContext {

    func create<DBEntity>(_ model: DBEntity.Type) -> DBEntity? where DBEntity : Storable {
        let entityDescription =  NSEntityDescription.entity(
            forEntityName: String.init(describing: model.self),
            in: managedContext!)

        let entity = NSManagedObject(
            entity: entityDescription!,
            insertInto: managedContext)
        return entity as? DBEntity
    }

    func save(object: Storable) throws { }

    func saveAll(objects: [Storable]) throws { }

    func update(object: Storable) throws { }

    func delete(object: Storable) throws { }

    func deleteAll(_ model: Storable.Type) throws { }

    func fetch(_ model: Storable.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable] {
        return []
    }
}
