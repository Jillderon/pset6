//
//  BookViewController.swift
//  jillderon-pset6
//
//  Created by Jill de Ron on 09-12-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var NameBook: UILabel!
    @IBOutlet weak var AuthorBook: UILabel!
    @IBOutlet weak var ImageBook: UIImageView!
    @IBOutlet weak var DescriptionBook: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestHTTPS()
    }
    
    // Make a HTTPS request. Cited from http://stackoverflow.com/questions/32107690/cant-get-value-from-google-books-json-api
    func requestHTTPS(){
        
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=child&filter=free-ebooks&key=AIzaSyAQPvd_9YuocHpy7ms-7TthQUQI4qKx9fs") else {
            print("the url is not valid")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error -> Void in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary else {
                print("the JSON is not valid")
                return
            }

            let items = jsonResult.value(forKey: "items") as! NSArray
            let book = items[0] as! NSDictionary
//            let downloadDetails = book.value(forKey: "webReaderLink") as? String
            let bookDetails = book.value(forKey: "volumeInfo") as! NSDictionary
            let authorBook = bookDetails.value(forKey: "authors") as! NSArray
            let nameBook = bookDetails.value(forKey: "title") as! String

            self.NameBook.text = nameBook
            self.AuthorBook.text = authorBook[0] as? String
//            self.DescriptionBook.text = downloadDetails

        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
