//
//  ProductListViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 24.10.2021.
//

import UIKit

class ProductListViewController: UIViewController {
    var mainSubcategory: SubcategoryRealm?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

  

}

extension ProductListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        cell.nameLabel.text = "name"
        return cell
    }
    
    
}
