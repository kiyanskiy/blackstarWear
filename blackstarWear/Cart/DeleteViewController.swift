//
//  DeleteViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 10.11.2021.
//

import UIKit
import RealmSwift
class DeleteViewController: UIViewController {
    var currentProduct: ProductRealm?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func confirmDelete(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        if let product = currentProduct{
            try! Realm().write{
                try! Realm().delete(product)
            }
        }
        self.performSegue(withIdentifier: "OpenCart", sender: self)
    }
    
    @IBAction func cancelDelete(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "OpenCart", sender: self)
    }
    
}
