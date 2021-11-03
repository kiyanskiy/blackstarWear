//
//  ProductListViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 24.10.2021.
//

import UIKit
import MBProgressHUD
class ProductListViewController: UIViewController {
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    var mainSubcategory: Subcategories?
    var products: [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentCathegory = mainSubcategory{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            DataLoader().loadProducts(categoryId: currentCathegory.id){ result in
                
                var newArray: [Product] = []
                for (_,product) in result{
                    newArray.append(product)
                }
                self.products = newArray.sorted{ $0.sortOrder < $1.sortOrder }
                self.ProductCollectionView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}


extension ProductListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        cell.fillCell(products[indexPath.row])
        return cell
    }
    
    
}

