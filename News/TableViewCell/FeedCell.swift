//
//  FeedCell.swift
//  News
//
//  Created by Sasha Voloshanov on 4/12/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

struct FeedNews {
    let link: String
    let title: String
    let date: String
    let image: String?
}

class FeedCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var link: UIButton!
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var imagesView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func openURL(_ link: String) {
        let URL = Foundation.URL(string: "http://\(link.uppercased())")!
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.openURL(URL)
        }
    }
    
    @IBAction func openUrl(_ sender: UIButton) {
        let link = sender.titleLabel?.text
        if let link = link {
            openURL(link)
        }
    }
    
    func initilizate(feed: FeedNews) {
        date.text = feed.date
        title.text = feed.title
        link.setTitle(feed.link, for: .normal)
        print(feed.image!)
        if feed.image != nil && feed.image != "" {
            Alamofire.request(feed.image!).responseImage { response in
                let imageNews = response.result.value as! UIImage
                self.imagesView.image = imageNews
                self.imagesView.bounds.size = CGSize(width: self.imagesView.frame.size.width, height: 190)
            }
            
        } else {
            imagesView.bounds.size = CGSize(width: 0, height: 0)
        }
        
    }
}
