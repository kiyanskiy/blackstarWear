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
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var contentCellView: UIView!
    
    func fillCell(_ product: Product){
        self.nameLabel.text = product.name
        self.productImageView.layer.cornerRadius = 5
        self.buyButton.layer.cornerRadius = self.buyButton.frame.height / 2
        self.priceLabel.text = String(product.price) + " р."
        MBProgressHUD.showAdded(to: self.contentCellView, animated: true)
        AF.request("https://blackstarshop.ru/\(product.mainImage)").response { response in
            if let data = response.data {
                self.productImageView.image =  UIImage(data: data)
            }
            MBProgressHUD.hide(for: self.contentCellView, animated: true)
        }
    }
}
