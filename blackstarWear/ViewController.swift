//
//  ViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 09.08.2021.
//

import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.tableFooterView = UIView()
        DataLoader().loadCategories { result in
            let allCategories = try! Realm().objects(CategoryRealm.self)
            try! Realm().write{
               try! Realm().delete(allCategories)
            }
            let allSubcategories = try! Realm().objects(SubcategoryRealm.self)
            try! Realm().write{
               try! Realm().delete(allSubcategories)
            }
            for category in result.allCategories{
                let newCategory = CategoryRealm()
                newCategory.name = category.name
                newCategory.sortOrder = category.sortOrder
                newCategory.image = category.image
                newCategory.iconImage = category.iconImage
                newCategory.iconImageActive = category.iconImageActive
                AF.request("https://blackstarshop.ru/\(category.image)").response { response in
                    if let data = response.data {
                        try! Realm().write{ newCategory.imageData = data }
                    }
                }
                AF.request("https://blackstarshop.ru/\(category.iconImage)").response { response in
                    if let data = response.data {
                        try! Realm().write{ newCategory.iconImageData = data }
                    }
                }
                AF.request("https://blackstarshop.ru/\(category.iconImageActive)").response { response in
                    if let data = response.data {
                        try! Realm().write{ newCategory.iconImageActiveData = data }
                    }
                }
                for subcategory in category.subcategories{
                    let newSubcategory = SubcategoryRealm()
                    newSubcategory.name = subcategory.name
                    newSubcategory.id = subcategory.id
                    newSubcategory.sortOrder = subcategory.sortOrder
                    newSubcategory.type = subcategory.type
                    newSubcategory.iconImage = subcategory.iconImage
                    AF.request("https://blackstarshop.ru/\(subcategory.iconImage)").response { response in
                        if let data = response.data {
                            try! Realm().write{ newSubcategory.iconImageData = data }
                        }
                    }
                    newCategory.subcategories.append(newSubcategory)
                    try! Realm().write{
                        try! Realm().add(newSubcategory)
                    }
                }
                try! Realm().write{
                    try! Realm().add(newCategory)
                }
                
            }
            self.categoriesTableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currentCategory = try! Realm().objects(CategoryRealm.self)[categoriesTableView.indexPathForSelectedRow!.row]
        (segue.destination as! SubcategoriesViewController).mainCategory = currentCategory
    }

}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return try! Realm().objects(CategoryRealm.self).count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoriesTableViewCell
        let allCategories = try! Realm().objects(CategoryRealm.self)
        if allCategories.count > 0 {
            cell.fillCell(allCategories[indexPath.row])
        }
        return cell
    }
    
    
}

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
