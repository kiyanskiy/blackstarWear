//
//  CategoriesTableViewCell.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.09.2021.
//

import UIKit
import Alamofire
import AlamofireImage
class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryImageView.layer.cornerRadius = 37.5
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func fillCell(_ category: Category){
        if let url = URL(string: "https://blackstarshop.ru/\(category.image)") {
            
            self.categoryImageView.af.setImage(withURL: url)
            
        }
        self.categoryNameLabel.text = category.name
    }
    
}
