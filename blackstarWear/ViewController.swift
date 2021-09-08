//
//  ViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 09.08.2021.
//

import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.tableFooterView = UIView()
        DataLoader().loadCategories { result in
            print (result.accessories.name)
            
        }
    }


}

