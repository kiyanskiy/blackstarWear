//
//  RealmData.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 08.09.2021.
//

import Foundation
import RealmSwift
import UIKit
class SubcategoryRealm: Object{
    @objc dynamic var name = ""
    @objc dynamic var sortOrder = ""
    @objc dynamic var id = ""
    @objc dynamic var iconImage = ""
    @objc dynamic var type = ""
    @objc dynamic var iconImageData: Data? = nil
}

class CategoryRealm: Object{
    @objc dynamic var name = ""
    @objc dynamic var sortOrder = ""
    @objc dynamic var image  = ""
    @objc dynamic var iconImage = ""
    @objc dynamic  var iconImageActive = ""
    @objc dynamic var imageData: Data? = nil
    @objc dynamic var iconImageData: Data? = nil
    @objc dynamic  var iconImageActiveData: Data? = nil
    var subcategories = List<SubcategoryRealm>()
}

