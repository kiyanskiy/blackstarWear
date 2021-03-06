//
//  SubcategoriesTableViewCell.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 14.09.2021.
//

import UIKit
import Alamofire
class SubcategoriesTableViewCell: UITableViewCell {
    var subcategoryId = ""
    @IBOutlet weak var subcategoryNameLabel: UILabel!
    @IBOutlet weak var subcategoryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func fillCell(_ subcategory: Subcategories){
        self.subcategoryId = subcategory.id
        self.subcategoryNameLabel.text = subcategory.name
        if subcategory.iconImage == ""{
            self.subcategoryImageView.image = UIImage(named: "icons-3")
        }else{
            if let url = URL(string: "https://blackstarshop.ru/\(subcategory.iconImage)") {
                
                self.subcategoryImageView.af.setImage(withURL: url)
            }

        }
    }
}
