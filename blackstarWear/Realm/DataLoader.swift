//
//  CategoriesLoader.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.09.2021.
//

import Foundation
import Alamofire

class DataLoader{
   
    func loadCategories(completion: @escaping (Categories) -> Void){
        
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/categories").response { (responseData) in guard let data = responseData.data else {return}
            do{
                let result = try JSONDecoder().decode(Categories.self, from: data)
                completion(result)
            }catch{
                print("Error decoding: \(error)")
            }
        }
    }
    func loadProducts(categoryId: String, completion: @escaping (Products) -> Void){
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=" + categoryId).response { (responseData) in guard let data = responseData.data else {return}
            do{
                let products = try JSONDecoder().decode(Products.self, from: data)
                completion(products)
            }catch{
                print("Error decoding: \(error)")
            }
        }
    }
}
