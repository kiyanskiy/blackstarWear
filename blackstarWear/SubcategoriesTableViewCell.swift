//
//  SubcategoriesTableViewCell.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 14.09.2021.
//

import UIKit

class SubcategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var subcategoryNameLabel: UILabel!
    @IBOutlet weak var subcategoryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.subcategoryImageView.layer.cornerRadius = 37.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell(_ subcategory: SubcategoryRealm){
        self.subcategoryNameLabel.text = subcategory.name
        if let imageData = subcategory.iconImageData {
            self.subcategoryImageView.image =  UIImage(data: imageData)
        }
    }
}
