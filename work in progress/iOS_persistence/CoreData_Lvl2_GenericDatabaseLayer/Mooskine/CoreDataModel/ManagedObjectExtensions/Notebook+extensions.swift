//
//  Notebook+extra.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 23/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

// insert any custom code you need to add on top of the auto-generated class
extension NotebookEntity {

    public override func awakeFromInsert() {
        super.awakeFromInsert()

        creationDate = Date()
    }
}
