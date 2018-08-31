//
//  Item.swift
//  Todoey
//
//  Created by Mat Keller on 8/30/18.
//  Copyright © 2018 Mat Keller. All rights reserved.
//

import Foundation

//Declare as Codable so we can Encode and Decode the data and save it to plist.  This means
//all vars must be basic data types (String, Bool, Int, etc.)
class Item: Codable {
    
    var title: String = ""
    var done: Bool = false
}
