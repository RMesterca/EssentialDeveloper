////
////  ListDataSource.swift
////  Mooskine
////
////  Created by Raluca Mesterca on 24/04/2020.
////  Copyright © 2020 Udacity. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CoreData
//
//class ListDataSource<EntityType: NSManagedObject, CellType: UITableViewCell>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate  {
//
//    private let tableView: UITableView
//    private let managedObjectContext: NSManagedObjectContext
//    private let fetchRequest: NSFetchRequest<EntityType>
//    private let configureCompletion: (CellType, EntityType) -> Void
//
//    var dataController: DataController!
//    var fetchedResultsController: NSFetchedResultsController<EntityType>!
//
//
//    init(
//        tableView: UITableView,
//        managedObjectContext: NSManagedObjectContext,
//        fetchRequest: NSFetchRequest<EntityType>,
//        configure: @escaping (CellType, EntityType) -> Void
//    ) {
//        self.tableView = tableView
//        self.managedObjectContext = managedObjectContext
//        self.fetchRequest = fetchRequest
//        self.configureCompletion = configure
//    }
//
//    func setupFetchController() {
//        fetchedResultsController = NSFetchedResultsController(
//            fetchRequest: fetchRequest,
//            managedObjectContext: dataController.viewContext,
//            sectionNameKeyPath: nil,
//            cacheName: "notebooks")
//
//        fetchedResultsController.delegate = self
//
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            fatalError()
//        }
//    }
//
//
//    // MARK: UITableViewDataSource
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchedResultsController.sections?.count ?? 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let aNotebook = fetchedResultsController.object(at: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCell.defaultReuseIdentifier, for: indexPath) as! CellType
//
//        // Configure cell
//        cell.nameLabel.text = aNotebook.name
//
//        if let count = aNotebook.notes?.count {
//            let pageString = count == 1 ? "page" : "pages"
//            cell.pageCountLabel.text = "\(count) \(pageString)"
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        switch editingStyle {
//        case .delete: deleteNotebook(at: indexPath)
//        default: () // Unsupported
//        }
//    }
//
//    // MARK: NSFetchedResultsControllerDelegate
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//
//    func controller(
//        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
//        didChange anObject: Any,
//        at indexPath: IndexPath?,
//        for type: NSFetchedResultsChangeType,
//        newIndexPath: IndexPath?
//    ) {
//
//        switch type {
//        case .insert: tableView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete: tableView.deleteRows(at: [indexPath!], with: .fade)
//        case .move: tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        case .update: tableView.reloadRows(at: [indexPath!], with: .fade)
//        @unknown default: break
//        }
//    }
//
//    func controller(
//        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
//        didChange sectionInfo: NSFetchedResultsSectionInfo,
//        atSectionIndex sectionIndex: Int,
//        for type: NSFetchedResultsChangeType
//    ) {
//        let indexSet = IndexSet(integer: sectionIndex)
//        switch type {
//        case .insert: tableView.insertSections(indexSet, with: .fade)
//        case .delete: tableView.deleteSections(indexSet, with: .fade)
//        default:
//            assertionFailure("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
//        }
//    }
//}
//
//
