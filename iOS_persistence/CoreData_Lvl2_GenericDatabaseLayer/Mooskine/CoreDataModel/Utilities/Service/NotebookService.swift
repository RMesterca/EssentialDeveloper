//
//  NotebookService.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class NotebookService {

    func save(notebook: Notebook) {
        do {
            try DBManager.shared.notebookDao.save(object: notebook)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }

    func fetchNotebook(by name: String) -> Notebook? {
        return DBManager.shared.notebookDao.findById(name: name)
    }

    func fetchNotebooks() -> [Notebook?] {
        let sorted = Sorted(key: "creationDate", ascending: false)
        return DBManager.shared.notebookDao.fetch(predicate: nil, sorted: sorted)
    }

    func deleteNotebook() {

    }
}
