//
//  DomainBaseEntities.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class Notebook: DomainBaseEntity, Codable {
    var name: String?
    var creationDate: Date?

    var notes: [Note]
}
