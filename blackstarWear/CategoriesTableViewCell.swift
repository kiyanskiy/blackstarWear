//
//  CategoriesTableViewCell.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.09.2021.
//

import UIKit
import Alamofire
class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var CategoryImageView: UIImageView!
    
    @IBOutlet weak var CategoryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.CategoryImageView.layer.cornerRadius = 37.5
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func fillCell(_ category: Category){
        AF.request("https://blackstarshop.ru/\(category.image)").response { response in
            if let data = response.data {
                self.CategoryImageView.image =  UIImage(data: data)
            }
        }
        self.CategoryNameLabel.text = category.name
    }

}
