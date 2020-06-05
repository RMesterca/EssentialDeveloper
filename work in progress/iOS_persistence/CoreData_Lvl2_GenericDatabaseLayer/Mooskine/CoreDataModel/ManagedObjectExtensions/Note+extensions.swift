//
//  Note+extensions.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 23/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

extension NoteEntity {

   public override func awakeFromInsert() {
        super.awakeFromInsert()

        creationDate = Date()
    }
}
