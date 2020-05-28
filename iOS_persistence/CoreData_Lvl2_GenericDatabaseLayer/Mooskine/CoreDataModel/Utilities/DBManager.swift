//
//  DBManager.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class DBManager {

    // MARK: - Private properties
    private var storageContext: StorageContext?

    // MARK: - Public properties
    static var shared = DBManager()

    lazy var noteDao = NoteDAO(storageContext: storageContextImpl())
    lazy var notebookDao = NotebookDAO(storageContext: storageContextImpl())

    private init() {
    }

    static func setup(storageContext: StorageContext) {
        shared.storageContext = storageContext
    }


    private func storageContextImpl() -> StorageContext {
        if self.storageContext != nil {
            return self.storageContext!
        }
        fatalError("You must call setup to configure the StoreContext before accessing any dao")
    }
}
