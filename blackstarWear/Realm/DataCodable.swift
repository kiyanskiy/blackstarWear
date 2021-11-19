//
//  DataCodable.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.09.2021.
//

import Foundation


typealias Categories = [String: Category]

struct Category: Codable{
    let name: String
    let sortOrder: Int
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
            self.sortOrder = try container.decode(Int.self, forKey: .sortOrder)

        } catch {
            self.sortOrder = Int(try container.decode(String.self, forKey: .sortOrder)) ?? 0
        }


    }
    
}

struct Subcategories: Codable{
    let name: String
    let sortOrder: Int
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
            self.sortOrder = try container.decode(Int.self, forKey: .sortOrder)

        } catch {
            self.sortOrder = Int(try container.decode(String.self, forKey: .sortOrder)) ?? 0

        }
        do {
            self.id = try container.decode(String.self, forKey: .id)

        } catch {
            self.id = String(try container.decode(Int.self, forKey: .id))

        }

        
    }
}

struct Product: Codable{
    let name: String
    let description: String
    let colorName: String
    let price: Int
    let sortOrder: Int
    let colorImageURL: String
    let mainImage: String
    let productImages: [ProductImage]
    let offers: [Offer]
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case colorName = "colorName"
        case price = "price"
        case sortOrder = "sortOrder"
        case colorImageURL = "colorImageURL"
        case mainImage = "mainImage"
        case productImages = "productImages"
        case offers = "offers"
    }
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.colorName = try container.decode(String.self, forKey: .colorName)
        self.colorImageURL = try container.decode(String.self, forKey: .colorImageURL)
        self.mainImage = try container.decode(String.self, forKey: .mainImage)
        self.productImages = try container.decode([ProductImage].self, forKey: .productImages)
        self.offers = try container.decode([Offer].self, forKey: .offers)
        do {
            self.sortOrder = try container.decode(Int.self, forKey: .sortOrder)
            
        } catch {
            self.sortOrder = Int(try container.decode(String.self, forKey: .sortOrder)) ?? 0
            
        }
        do {
            self.price = Int(try container.decode(Float.self, forKey: .price))
            
        } catch {
            self.price = Int(Float(try container.decode(String.self, forKey: .price)) ?? 0)
            
        }
        
    }
}

struct ProductImage: Codable{
    let imageURL: String
    let sortOrder: String
}

struct Offer: Codable{
    let size: String
}

typealias Products = [String: Product]

