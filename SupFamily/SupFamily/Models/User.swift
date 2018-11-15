//
//  User.swift
//  SupFamily
//
//  Created by Supinfo on 15/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import Foundation

struct User: Decodable{
    let userId: Int
    let lasName: String
    let firstName: String
    let latitude: Double?
    let longitude: Double?
}
