//
//  Note.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class Note: DomainBaseEntity, Codable {
    var attribute: String?
    var creationDate: Date?

    var notebook: Note

}
