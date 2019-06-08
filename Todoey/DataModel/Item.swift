//
//  item.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 08/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import Foundation

class Item {
    
    var title: String = ""
    var done: Bool = false

    init (){
        self.title=""
        self.done=false
    }
    
    init (title: String, done: Bool){
        self.title=title
        self.done=done
    }
    
}
