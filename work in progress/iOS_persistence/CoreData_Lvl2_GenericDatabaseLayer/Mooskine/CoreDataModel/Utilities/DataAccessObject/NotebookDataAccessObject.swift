//
//  NotebookDataAccessObject.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

protocol NotebookDAOProtocol {
    func findById(name: String) -> Notebook?
}

class NotebookDAO: BaseDataAccessObject<Notebook, NotebookEntity> {

    func findById(name: String) -> Notebook? {
        return super.fetch(predicate: NSPredicate(format: "name = %", name)).last
    }


}
