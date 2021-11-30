//
//  ProductCollectionViewCell.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 27.10.2021.
//

import UIKit
import Alamofire
import MBProgressHUD
class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentCellView: UIView!
    
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    func fillCell(_ product: Product){
        let width = UIScreen.main.bounds.width / 2 - 30
        imageWidthConstraint.constant = width
        imageHeightConstraint.constant = width
        self.nameLabel.text = product.name
        self.priceLabel.text = String(product.price) + " р."
        MBProgressHUD.showAdded(to: self.contentCellView, animated: true)
        if let url = URL(string: "https://blackstarshop.ru/\(product.mainImage)") {
            
            self.productImageView.af.setImage(withURL: url)
            MBProgressHUD.hide(for: self.contentCellView, animated: true)
        }
    }
}
