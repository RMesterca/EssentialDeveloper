//
//  Storable.swift
//  Mooskine
//
//  Created by Raluca Mesterca on 28/04/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

/// View Controllers and business layers (services) should not know about the existence of NSManagedObjects (Core Data entities)
public protocol Storable {
    init()
}


