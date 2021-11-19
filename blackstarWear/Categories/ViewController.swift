//
//  ViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 09.08.2021.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    var categories: [Category] = []
    @IBOutlet weak var categoriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.tableFooterView = UIView()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DataLoader().loadCategories { result in
            
            var newArray: [Category] = []
            for (_,category) in result{
                if category.subcategories.count > 0 && category.image != ""{
                    newArray.append(category)
                }
            }
            self.categories = newArray.sorted{ $0.sortOrder < $1.sortOrder }
            self.categoriesTableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextCategories"{
            let currentCategory = categories[categoriesTableView.indexPathForSelectedRow!.row]
            (segue.destination as! SubcategoriesViewController).mainCategory = currentCategory
        }
    }

}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoriesTableViewCell
        if categories.count > 0 {
            cell.fillCell(categories[indexPath.row])
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
