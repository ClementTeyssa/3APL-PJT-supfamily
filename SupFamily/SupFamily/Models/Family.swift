//
//  Family.swift
//  SupFamily
//
//  Created by Supinfo on 15/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import Foundation

struct Family: Decodable{
    let id: Int
    let name: String
    let members: [User]?
}
