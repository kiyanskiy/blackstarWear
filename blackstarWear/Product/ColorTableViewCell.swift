//
//  ColorTableViewCell.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 05.11.2021.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
