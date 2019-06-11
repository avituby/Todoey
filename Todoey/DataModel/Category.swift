//
//  Category.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 11/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
