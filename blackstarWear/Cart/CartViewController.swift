//
//  CartViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 05.11.2021.
//

import UIKit
import RealmSwift
class CartViewController: UIViewController {
    
    @IBOutlet weak var cartsProductsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cartsProductsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartsProductsTableView.reloadData()
    }
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.cartsProductsTableView.reloadData()
            }
        }
    }

}
extension CartViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(try! Realm().objects(ProductRealm.self).count)
        return try! Realm().objects(ProductRealm.self).count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartsProduct") as! CartsProductTableViewCell
        print(try! Realm().objects(ProductRealm.self).count)
        let product = try! Realm().objects(ProductRealm.self)[indexPath.row]
        cell.fillCell(product)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
