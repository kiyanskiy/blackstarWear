//
//  CartsProductTableViewCell.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 10.11.2021.
//

import UIKit
import Alamofire
import RealmSwift
class CartsProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    var currentProduct: ProductRealm?
    override func awakeFromNib() {
        super.awakeFromNib()

    }
     
    @IBAction func showDeletionScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondViewController = storyboard.instantiateViewController(identifier: "DeletionViewController") as? DeleteViewController else { return }
        secondViewController.currentProduct = currentProduct
        self.window?.rootViewController?.present(secondViewController, animated: true, completion: nil)
    }
    
    func fillCell(_ product: ProductRealm){
        currentProduct = product
        priceLabel.text = String(product.price) + " р."
        colorLabel.text = "Цвет: " + product.colorName
        nameLabel.text = product.name
        sizeLabel.text = "Размер: " + product.size
        AF.request("https://blackstarshop.ru/\(product.mainImage)").response { response in
            if let data = response.data {
                self.productImage.image =  UIImage(data: data)
            }
        }
    }
    
}
