//
//  UserResponseElement.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/22/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
 import RealmSwift
class UserResponseElement: Object, Codable {
       @objc dynamic var  userId: Int = 0
       @objc dynamic var id: Int = 0
       @objc dynamic var title: String = ""
       @objc dynamic var body: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
  
}
