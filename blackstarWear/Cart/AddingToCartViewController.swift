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
        
    }
    func createNewRealProduct(){
        guard let currentProduct = selectedProduct else {
            return
        }
        guard let currentSize = selectedSize, let currentColor = selectedColor else {
            let alert = UIAlertController(title: "", message: "Выберите размер и цвет товара", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let newProduct = ProductRealm()
            newProduct.name = currentProduct.name
            newProduct.price = currentProduct.price
            newProduct.mainImage = currentProduct.mainImage
            newProduct.colorName = currentColor.color.description
            newProduct.size = currentSize.description
            try! realm.write {
                realm.add(newProduct)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension AddingToCartViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == colorTableView{
            return array.count
        }else{
            guard let currentColor = selectedColor else{
                return 0
            }
            return currentColor.size.count
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
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == colorTableView{
            selectedColor = array[indexPath.row]
            selectedSize = nil
            self.sizeTableView.reloadData()
        }else{
            guard let currentColor = selectedColor else{
                let alert = UIAlertController(title: "", message: "Сначала выберите цвет товара", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            selectedSize = currentColor.size[indexPath.row]
        }
        
    }
}
