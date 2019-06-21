//
//  Item.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 11/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var createDate: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
