//
//  SubcategoriesViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 14.09.2021.
//

import UIKit

class SubcategoriesViewController: UIViewController {
    @IBOutlet weak var subcategoriesTableView: UITableView!
    var mainCategory: CategoryRealm?
    override func viewDidLoad() {
        super.viewDidLoad()
        subcategoriesTableView.tableFooterView = UIView()
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
