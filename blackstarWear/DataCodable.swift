//
//  DataCodable.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.09.2021.
//

import Foundation

struct Result: Codable{
    let accessories: Category
    let womens: Category
    let mens: Category
    let children: Category
    let collections: Category
    let sales: Category
    let new: Category
    let marketplace: Category
    let preorder: Category
    var allCategories: [Category]
    enum CodingKeys: String, CodingKey {
        case accessories = "67"
        case womens = "68"
        case mens = "69"
        case children = "73"
        case collections = "74"
        case sales = "156"
        case new = "165"
        case marketplace = "233"
        case preorder = "0"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.accessories = try container.decode(Category.self, forKey: .accessories)
        self.womens = try container.decode(Category.self, forKey: .womens)
        self.mens = try container.decode(Category.self, forKey: .mens)
        self.children = try container.decode(Category.self, forKey: .children)
        self.collections = try container.decode(Category.self, forKey: .collections)
        self.sales = try container.decode(Category.self, forKey: .sales)
        self.new = try container.decode(Category.self, forKey: .new)
        self.marketplace = try container.decode(Category.self, forKey: .marketplace)
        self.preorder = try container.decode(Category.self, forKey: .preorder)
        self.allCategories = [self.accessories, self.womens, self.mens, self.children, self.collections, self.sales, self.new, self.marketplace, self.preorder]
    }
}

struct Category: Codable{
    let name: String
    let sortOrder: String
    let image: String
    let iconImage: String
    let iconImageActive: String
    let subcategories: [Subcategories]
    
    enum CodingKeys: String, CodingKey {
        case sortOrder = "sortOrder"
        case name = "name"
        case image = "image"
        case iconImage = "iconImage"
        case iconImageActive = "iconImageActive"
        case subcategories = "subcategories"
    }
    
    init(from decoder: Decoder) throws {
            
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.iconImage = try container.decode(String.self, forKey: .iconImage)
        self.iconImageActive = try container.decode(String.self, forKey: .iconImageActive)
        self.subcategories = try container.decode([Subcategories].self, forKey: .subcategories)
        do {
            self.sortOrder = try container.decode(String.self, forKey: .sortOrder)

        } catch {
            self.sortOrder = String(try container.decode(Int.self, forKey: .sortOrder))
                  
        }

        
    }
    
}

struct Subcategories: Codable{
    let name: String
    let sortOrder: String
    let id: String
    let iconImage: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case sortOrder = "sortOrder"
        case name = "name"
        case id = "id"
        case iconImage = "iconImage"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
            
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.iconImage = try container.decode(String.self, forKey: .iconImage)
        self.type = try container.decode(String.self, forKey: .type)
        do {
            self.sortOrder = try container.decode(String.self, forKey: .sortOrder)

        } catch {
            self.sortOrder = String(try container.decode(Int.self, forKey: .sortOrder))
                  
        }
        do {
            self.id = try container.decode(String.self, forKey: .id)

        } catch {
            self.id = String(try container.decode(Int.self, forKey: .id))
                  
        }

        
    }
}

struct Products: Codable{
    let name: String
    let description: String
    let colorName: String
    let price: String
    let colorImageURL: String
    let mainImage: String
    let productImages: [ProductImages]
    let offers: [Offers]
}

struct ProductImages: Codable{
    let imageURL: String
    let sortOrder: String
}

struct Offers: Codable{
    let size: String
}
