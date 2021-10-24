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
    var mainCategory: CategoryRealm?
    override func viewDidLoad() {
        super.viewDidLoad()
        subcategoriesTableView.tableFooterView = UIView()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currentCell = subcategoriesTableView.cellForRow(at: subcategoriesTableView.indexPathForSelectedRow!) as! SubcategoriesTableViewCell
        let allCategories = try!  Realm().objects(SubcategoryRealm.self)
        for subcategory in allCategories{
            if subcategory.id == currentCell.subcategoryId{
                print(subcategory.name)
                print(subcategory.id)
            }
        }
        
      //  (segue.destination as! ProductListViewController).mainSubcategory = currentCategory
    }
}
extension SubcategoriesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentCategory = self.mainCategory{
            return currentCategory.subcategories.count
        }else{
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoryCell") as! SubcategoriesTableViewCell
        if let currentCategory = self.mainCategory{
            cell.fillCell(currentCategory.subcategories[indexPath.row])
        }
        return cell
    }
    
    
}
