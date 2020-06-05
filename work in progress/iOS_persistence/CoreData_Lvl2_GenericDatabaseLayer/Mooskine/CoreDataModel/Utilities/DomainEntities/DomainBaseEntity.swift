//
//  DomainBaseEntity.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import CoreData

class DomainBaseEntity: Mappable {
    var objectID: NSManagedObjectID?

    required init() {
    }
}
