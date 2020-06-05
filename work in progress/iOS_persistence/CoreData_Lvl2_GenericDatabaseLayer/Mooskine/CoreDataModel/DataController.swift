//
//  DataController.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 23/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

// NOTE: for devs

// run time argument set in the scheme
// -com.apple.CoreData.ConcurrencyDebug 1
// app crash if operations accessed the context from the wrong queue
// 1, 2, 3 - level of detail in the stack trace
// 3 the most verbose output

typealias loadCompletion = (() -> Void)?

class DataController {

    let persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var backgroundContext: NSManagedObjectContext!

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    func configureContexts() {
        backgroundContext = persistentContainer.newBackgroundContext()

        // in case of context merge conflicts
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        //prefers the changes made to the objects made in the context
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // prefers the persistent store state of the object
        viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }

    func load(completion: loadCompletion = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else { fatalError() }
            self.autoSave()
            self.configureContexts()
            completion?()
        }
    }

    func savedIfNeeded() {
        guard viewContext.hasChanges else { return }
        do { try viewContext.save() }
        catch { print(error.localizedDescription) }
    }
}

// MARK: AutoSave
extension DataController {

    func autoSave(interval: TimeInterval = 30) {
        guard interval > 0 else { return }
        savedIfNeeded()

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSave(interval: interval)
        }
    }
}
