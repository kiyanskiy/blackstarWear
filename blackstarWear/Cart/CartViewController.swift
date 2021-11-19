//
//  CartViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 05.11.2021.
//

import UIKit
import RealmSwift
class CartViewController: UIViewController {
//    let realm = try! Realm()
//    var products: [ProductRealm] = []
    
    @IBOutlet weak var CartsProductsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let productsRealm = realm.objects(ProductRealm.self)
//        for currentProduct in productsRealm{
//            products.append(currentProduct)
//        }
//        CartsProductsTableView.reloadData()
        
       
    }
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.CartsProductsTableView.reloadData()
            }
        }
    }

}
extension CartViewController: UITableViewDataSource{
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
    
    
}
