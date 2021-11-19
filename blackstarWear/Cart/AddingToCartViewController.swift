//
//  AddingToCartViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 05.11.2021.
//

import UIKit
import RealmSwift
let whiteColor = ColorSize("Белый",[.S,.M,.L,.XL])
let redColor = ColorSize("Красный",[.S,.M,.L,.XXL])
let greenColor = ColorSize("Зеленый",[.L,.XL,.XXL])
let blackColor = ColorSize("Черный",[.S,.M,.L,.XL,.XXL])
let blueColor = ColorSize("Синий",[.S,.M,.XXL])
let yellowColor = ColorSize("Желтый",[.S,.XL,.XXL])


class AddingToCartViewController: UIViewController {
    let realm = try! Realm()
    let array = [whiteColor,redColor,greenColor,blackColor,blueColor,yellowColor]
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var colorTableView: UITableView!
    @IBOutlet weak var sizeTableView: UITableView!
    var selectedProduct: Product?
    var selectedColor: ColorSize?
    var selectedSize: Size?
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 10
        selectedColor = array[0]
        selectedSize = array[0].size[0]
        
    }
    
    @IBAction func addToCart(_ sender: Any) {
        let products = realm.objects(ProductRealm.self)
        if products.count != 0{
            var productExist = false
            for product in products{
                if selectedProduct != nil && selectedColor != nil && selectedSize != nil{
                    if product.name == selectedProduct!.name &&
                        product.colorName == selectedColor!.color.description &&
                        product.size == selectedSize!.description{
                        productExist = true
                    }
                }
            }
            if !productExist{
                createNewRealProduct()
            }
        }else{
            createNewRealProduct()
        }
        self.dismiss(animated: true, completion: nil)
    }
    func createNewRealProduct(){
        if selectedProduct != nil && selectedColor != nil && selectedSize != nil{
            let product = ProductRealm()
            product.name = selectedProduct!.name
            product.price = selectedProduct!.price
            product.mainImage = selectedProduct!.mainImage
            product.colorName = selectedColor!.color.description
            product.size = selectedSize!.description
            try! realm.write {
                realm.add(product)
            }
        }
    }
}



extension AddingToCartViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == colorTableView{
            return array.count
        }else{
            if selectedColor != nil{
                return selectedColor!.size.count
            }else{
                return array[0].size.count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == colorTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as! ColorTableViewCell
            cell.colorLabel.text = array[indexPath.row].color
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SizeCell") as! SizeTableViewCell
            if let currentColor = selectedColor{
                cell.sizeLabel.text = currentColor.size[indexPath.row].description
            }else{
                cell.sizeLabel.text = array[0].size[indexPath.row].description
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == colorTableView{
            selectedColor = array[indexPath.row]
            self.sizeTableView.reloadData()
        }else{
            selectedSize = selectedColor?.size[indexPath.row]
        }
        
    }
}