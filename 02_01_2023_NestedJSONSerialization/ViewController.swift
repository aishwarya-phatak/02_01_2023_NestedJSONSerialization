//
//  ViewController.swift
//  02_01_2023_NestedJSONSerialization
//
//  Created by Vishal Jagtap on 14/02/23.
//

import UIKit

class ViewController: UIViewController {
    var urlString : String?
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var newProduct : Product?

    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerializationDemo()
    }
    
    func jsonSerializationDemo(){
        urlString = "https://fakestoreapi.com/products"
        url = URL(string: urlString!)
        
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        urlSession?.dataTask(with: urlRequest!) { data, response, error in
            
           let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            //way 1
            for eachJSONObject in jsonResponse{
                let prDictionary = eachJSONObject as! [String : Any]
                let prId = prDictionary["id"] as! Int
                let prTitle = prDictionary["title"] as! String
                let prPrice = prDictionary["price"] as! Double
                
                let prRating = prDictionary["rating"] as! [String : Any]        //important
                let prRate = prRating["rate"] as! Double
                let prCount = prRating["count"] as! Int
                
                self.newProduct = Product(id: prId, title: prTitle, price: prPrice, rate: prRate, count: prCount)
  
                self.products.append(self.newProduct!)
            }
        }
    }
}

