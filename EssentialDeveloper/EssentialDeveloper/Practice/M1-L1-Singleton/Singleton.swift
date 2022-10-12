//
//  Singleton.swift
//  EssentialDeveloper
//
//  Created by Raluca Mesterca on 12.10.2022.
//

import UIKit

class ApiClient {

    // the key point is that this class needs to have a single point of access
    private init() { }

}

let client = ApiClient()
