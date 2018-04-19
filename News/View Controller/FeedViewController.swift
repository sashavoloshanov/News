//
//  ViewController.swift
//  News
//
//  Created by Sasha Voloshanov on 4/12/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var newsArray = [FeedNews]()
    var topNewsArray = [FeedNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Roboto-Bold", size: 42)!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
        self.tabBarController?.navigationItem.title = "News"

        
        getNews(url: Server.basicRequestURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getNews(url: String!) {
        if url != nil {
            Alamofire.request(url).responseData { response in
                
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    
                    let dictionary = self.convertToDictionary(text: utf8Text)
                    let array = dictionary![Server.Keys.results] as! [[String: Any]]
                    
                    array.forEach({ (dict) in
                        
                        let title = dict[Server.Keys.name] as! String
                        let date = "\(dict[Server.Keys.date]!)"
                        let imageInfo = dict[Server.Keys.image] as! [String: Any]
                        var imageNews = String()
                        if imageInfo.count != 0 {
                            imageNews = imageInfo[Server.Keys.imageURL] as! String
                            //MARK:- Alamofire Image
                        }
                        let feedNew = FeedNews(link: "google.com", title: title, date: date, image: imageNews)
                        self.newsArray.append(feedNew)
                        if feedNew.image != "" {
                            self.topNewsArray.append(feedNew)
                            
                        }
                    })
                    self.tableView.reloadData()
                    
                    guard var nextUrl = dictionary![Server.Keys.next] else {
                        return
                    }
                    print(nextUrl)
                    let stringURL = nextUrl as! String
                    if stringURL == nil {
                        self.getNews(url: nextUrl as! String)
                    }
                }
            }
            
        }
    }
    
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = Bundle.main.loadNibNamed("TopFeedCell", owner: self, options: nil)?.first as! TopFeedCell
            cell.initilizate(topFeed: topNewsArray)
            return cell
        }
        let cell = Bundle.main.loadNibNamed("FeedCell", owner: self, options: nil)?.first as! FeedCell
        cell.initilizate(feed: newsArray[indexPath.row - 1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 {
            if newsArray[indexPath.row - 1].image != "" {
                return 214
            }
            return 104
        }
        return 214
    }
    
}

