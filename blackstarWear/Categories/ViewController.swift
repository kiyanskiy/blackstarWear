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
        showCategories()
       
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextCategories"{
            if let indexPath = categoriesTableView.indexPathForSelectedRow{
                let currentCategory = categories[indexPath.row]
                if let subcategoriesController = segue.destination as? SubcategoriesViewController{
                    subcategoriesController.mainCategory = currentCategory
                }
            }
             
        }
    }

    func showCategories(){
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
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoriesTableViewCell{
            if categories.count > 0 {
                cell.fillCell(categories[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
