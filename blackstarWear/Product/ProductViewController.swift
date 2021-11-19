//
//  ProductViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.11.2021.
//

import UIKit
import Alamofire
class ProductViewController: UIViewController {
    var product: Product?
    var images: [UIImage] = []
    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesScrollView.delegate = self
        showProducts()
        
    }

    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        if let currentProduct = product{
            configureScrollView(currentProduct)
        }
        
    }
    func showProducts(){
        if let currentProduct = product{
            self.navigationItem.title = currentProduct.name
            pageControl.numberOfPages = currentProduct.productImages.count
            addToCartButton.layer.cornerRadius = 10
            priceLabel.text = String(currentProduct.price) + " руб."
            descriptionTextView.text = currentProduct.description
            nameLabel.text = currentProduct.name
            
            for image in currentProduct.productImages{
                AF.request("https://blackstarshop.ru/\(image.imageURL)").response { response in
                    if let data = response.data {
                        if let currentImage = UIImage(data: data){
                            self.images.append(currentImage)
                            self.configureScrollView(currentProduct)
                        }
                        
                    }
                }
            }
            if currentProduct.productImages.count == 0{
                AF.request("https://blackstarshop.ru/\(currentProduct.mainImage)").response { response in
                    if let data = response.data {
                        if let currentImage = UIImage(data: data){
                            self.images.append(currentImage)
                            self.configureScrollView(currentProduct)
                        }
                    }
                }
            }
            
        }
    }
    
    func configureScrollView(_ currentProduct: Product){
        
        imagesScrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(currentProduct.productImages.count), height: 300)
        imagesScrollView.isPagingEnabled = true
        
        for (index, image) in images.enumerated(){
            
            let page = UIImageView(frame: CGRect(x: CGFloat(index) * view.frame.size.width, y: 0, width: view.frame.size.width, height: 300))
            page.image = image
            page.contentMode = .scaleAspectFill
            imagesScrollView.addSubview(page)
            
        }
        imagesScrollView.contentOffset.y = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectSizeColor"{
            (segue.destination as! AddingToCartViewController).selectedProduct = self.product
        }
    }
}

extension ProductViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x / scrollView.frame.size.width)))
    }
}