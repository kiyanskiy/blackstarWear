//
//  SubcategoriesViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 14.09.2021.
//

import UIKit
import RealmSwift
class SubcategoriesViewController: UIViewController {
    @IBOutlet weak var subcategoriesTableView: UITableView!
    var subcategories: [Subcategories] = []
    var mainCategory: Category?
    override func viewDidLoad() {
        super.viewDidLoad()
        subcategoriesTableView.tableFooterView = UIView()
        if let currentCategory = mainCategory{
            for category in currentCategory.subcategories{
               subcategories.append(category)
              
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductList"{
            let currentCategory = mainCategory?.subcategories[subcategoriesTableView.indexPathForSelectedRow!.row]
            (segue.destination as! ProductListViewController).mainSubcategory = currentCategory
        }
    }
}
extension SubcategoriesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoryCell") as! SubcategoriesTableViewCell
        cell.fillCell(subcategories[indexPath.row])
        return cell
    }
    
    
}
