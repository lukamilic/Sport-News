//
//  ViewController.swift
//  Sports News
//
//  Created by Luka Milic on 1/30/17.
//  Copyright © 2017 Luka Milic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchNews()
        print("dsadasd")
    }
    
    func fetchNews() {
        
        let urlRequest = URLRequest(url: URL(string:"https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=96c8b7c473dc4e4d9b8e0cde6df14852")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
            
                
                if let articles = json["articles"] as? [[String:AnyObject]] {
                    
                    for article in articles {
                        
                        let news = News()
                        
                        if let title = article["title"] as? String, let author = article["author"] as? String, let desc = article["description"] as? String, let url = article["url"] as? String, let urlToImage = article["urlToImage"] as? String {
                            
                            news.title = title
                            news.author = author
                            news.desc = desc
                            news.url = url
                            news.img = urlToImage
                        }
                        
                        self.news.append(news)
                        print()
                    }
                }
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()

                }
                
            } catch let error {
                print(error)
        }
    }
        task.resume()
}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.news.count 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as? WebViewController
        
        webVC?.url = self.news[indexPath.item].url
        
        self.present(webVC!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        
        cell.title.text = self.news[indexPath.item].title
        cell.desc.text = self.news[indexPath.item].desc
        cell.author.text = self.news[indexPath.item].author
        cell.imgView.downloadImage(from: self.news[indexPath.item].img!)
        
        
        
        return cell
    }
}

extension UIImageView {
    
    func downloadImage(from url: String) {
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response ,error ) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            DispatchQueue.main.async {
                
                self.image = UIImage(data: data!)
            }
            
        }
        task.resume()
    }
}
















