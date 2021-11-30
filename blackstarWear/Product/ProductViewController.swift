//
//  ProductViewController.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 03.11.2021.
//

import UIKit
import Alamofire
import AlamofireImage
class ProductViewController: UIViewController {
    var product: Product?
    var images: [UIImage] = []
    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesScrollView.delegate = self
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
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
            descriptionLabel.text = currentProduct.description
            nameLabel.text = currentProduct.name
            
            for image in currentProduct.productImages{
                let downloader = ImageDownloader()
                let urlRequest = URLRequest(url: URL(string: "https://blackstarshop.ru/\(image.imageURL)")!)

                downloader.download(urlRequest, completion: { response in
                    
                    if case .success(let image) = response.result {
                        self.images.append(image)
                        self.configureScrollView(currentProduct)
                    }
                })
            }
            if currentProduct.productImages.count == 0{
                let downloader = ImageDownloader()
                let urlRequest = URLRequest(url: URL(string: "https://blackstarshop.ru/\(currentProduct.mainImage)")!)

                downloader.download(urlRequest, completion: { response in
                    
                    if case .success(let image) = response.result {
                        self.images.append(image)
                        self.configureScrollView(currentProduct)
                    }
                })
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
            if let addingToCartController = segue.destination as? AddingToCartViewController{
                addingToCartController.selectedProduct = self.product
            }
        }
    }
}

extension ProductViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x / scrollView.frame.size.width)))
    }
}
