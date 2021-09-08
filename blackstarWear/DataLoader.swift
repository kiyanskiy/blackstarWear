//
//  CategoriesLoader.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.09.2021.
//

import Foundation
import Alamofire

class DataLoader{
   
    func loadCategories(completion: @escaping (Result) -> Void){
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/categories").response { (responseData) in guard let data = responseData.data else {return}
            do{
                let result = try JSONDecoder().decode(Result.self, from: data)
                completion(result)
            }catch{
                print("Error decoding: \(error)")
            }
        }
    }
}
