//
//  RealmData.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 08.09.2021.
//

import Foundation
import RealmSwift
import UIKit

class ProductRealm: Object{
    @objc dynamic var name = ""
    @objc dynamic var size = ""
    @objc dynamic var colorName = ""
    @objc dynamic var price = 0
    @objc dynamic var colorImageURL = ""
    @objc dynamic var mainImage = ""
    @objc dynamic var count = 0
}
