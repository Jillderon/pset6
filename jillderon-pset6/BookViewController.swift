//
//  BookViewController.swift
//  jillderon-pset6
//
//  Created by Jill de Ron on 09-12-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    /// MARK: Outlets
    @IBOutlet weak var NameBook: UILabel!
    @IBOutlet weak var AuthorBook: UILabel!
    
    /// MARK: define variables
    let titles: [String] = ["happy", "girl", "dog", "history", "science", "beauty", "plant", "dinner", "life", "earth", "animals", "politics", "philosopy", "old", "mad"]
    
    var downloadLink = String()
    
    var indexTitle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestHTTPS(title: titles[indexTitle])

        if dayNumberOfWeek() == 2 {
            indexTitle = Int(arc4random_uniform(15))
            requestHTTPS(title: titles[indexTitle])
        } else {
            requestHTTPS(title: titles[indexTitle])
        }
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: NSDate() as Date).weekday
    }
    
    // Make a HTTPS request. Cited from http://stackoverflow.com/questions/32107690/cant-get-value-from-google-books-json-api
    func requestHTTPS(title: String){
        
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q="+title+"&filter=free-ebooks&key=AIzaSyAQPvd_9YuocHpy7ms-7TthQUQI4qKx9fs") else {
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
            let accessInfo = book.value(forKey: "accessInfo") as! NSDictionary
            let pdf = accessInfo.value(forKey: "pdf") as! NSDictionary
            
            let bookDetails = book.value(forKey: "volumeInfo") as! NSDictionary
            let authorBook = bookDetails.value(forKey: "authors") as! NSArray
            let nameBook = bookDetails.value(forKey: "title") as! String
            self.downloadLink = pdf.value(forKey: "downloadLink") as! String
            
            DispatchQueue.main.sync(){
                self.NameBook.text = nameBook
                self.AuthorBook.text = authorBook[0] as? String
            }

        }).resume()
    }

    // Button to open a link. Cited from Sharpkits Innovations at http://stackoverflow.com/questions/31628246/make-button-open-link-swift
    @IBAction func goToOnlineBook(_ sender: Any) {
        if let url = NSURL(string: self.downloadLink) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


