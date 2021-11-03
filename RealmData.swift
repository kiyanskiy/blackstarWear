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
    @objc dynamic var sortOrder = 0
    @objc dynamic var id = ""
    @objc dynamic var iconImage = ""
    @objc dynamic var type = ""
    @objc dynamic var iconImageData: Data? = nil
    var products = List<ProductRealm>()
}

class CategoryRealm: Object{
    @objc dynamic var name = ""
    @objc dynamic var sortOrder = 0
    @objc dynamic var image  = ""
    @objc dynamic var iconImage = ""
    @objc dynamic var iconImageActive = ""
    @objc dynamic var imageData: Data? = nil
    @objc dynamic var iconImageData: Data? = nil
    @objc dynamic var iconImageActiveData: Data? = nil
    var subcategories = List<SubcategoryRealm>()
}

class ProductRealm: Object{
    @objc dynamic var name = ""
    @objc dynamic var productDescription = ""
    @objc dynamic var colorName = ""
    @objc dynamic var price = ""
    @objc dynamic var colorImageURL = ""
    @objc dynamic var mainImage = ""
    var productImages = List<ProductImageRealm>()
    var offers = List<OfferRealm>()
}

class ProductImageRealm: Object{
    @objc dynamic var imageURL = ""
    @objc dynamic var sortOrder = ""
}

class OfferRealm: Object{
    @objc dynamic var size = ""
}

func deleteRealmData(){
    let allCategories = try! Realm().objects(CategoryRealm.self)
    try! Realm().write{
       try! Realm().delete(allCategories)
    }
    let allSubcategories = try! Realm().objects(SubcategoryRealm.self)
    try! Realm().write{
       try! Realm().delete(allSubcategories)
    }
    let allProductRealm = try! Realm().objects(ProductRealm.self)
    try! Realm().write{
       try! Realm().delete(allProductRealm)
    }
    let allCProductImageRealm = try! Realm().objects(ProductImageRealm.self)
    try! Realm().write{
       try! Realm().delete(allCProductImageRealm)
    }
    let allOfferRealm = try! Realm().objects(OfferRealm.self)
    try! Realm().write{
       try! Realm().delete(allOfferRealm)
    }
}
