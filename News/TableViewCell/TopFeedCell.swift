//
//  TopFeedCell.swift
//  News
//
//  Created by Sasha Voloshanov on 4/13/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class TopFeedCell: UITableViewCell {
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: PageControl!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var link: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imagesView: UIImageView!
    var topNewsFeed = [FeedNews]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pageControl.currentPage = 0
        imageScrollView.delegate = self as! UIScrollViewDelegate
        imageScrollView.isPagingEnabled = true
        imageScrollView.setContentOffset(CGPoint(x: imageScrollView.bounds.width * CGFloat(pageControl.currentPage), y: 0), animated: true)
        pageControl.addTarget(self, action: #selector(pageControlDidChangeCurrentPage(_:)), for: .valueChanged)
        
    }
    
    
    func setNews(newsFeed: FeedNews) {
        date.text = newsFeed.date
        title.text = newsFeed.title
        link.setTitle(newsFeed.link, for: .normal)
        if newsFeed.image != "" {
            Alamofire.request(newsFeed.image!).responseImage { response in
                let imageNews = response.result.value as! UIImage
                self.imagesView.image = imageNews
                self.imagesView.bounds.size = CGSize(width: self.imagesView.frame.size.width, height: 190)
            }
        }
        let contentSize = CGSize(width: (imageScrollView.bounds.width * CGFloat(pageControl.numberOfPages)),
                                 height: imageScrollView.bounds.height)
        imageScrollView.contentSize = contentSize
        
        pageControl.numberOfPages = Int(imageScrollView.contentSize.width / imageScrollView.bounds.width)
    }
    
    @objc func pageControlDidChangeCurrentPage(_ pageControl: PageControl) {
        imageScrollView.setContentOffset(CGPoint(x: imageScrollView.bounds.width * CGFloat(pageControl.currentPage), y: 0), animated: true)
        setNews(newsFeed: topNewsFeed[pageControl.currentPage])
    }
    
    func initilizate(topFeed: [FeedNews]) {
        print(pageControl.currentPage)
        topNewsFeed = topFeed
        if topNewsFeed.count != 0 {
            setNews(newsFeed: topNewsFeed[pageControl.currentPage])
            pageControl.numberOfPages = topFeed.count
        }
    }
    
    @IBAction func openUrl(_ sender: UIButton) {
        let link = sender.titleLabel?.text
        if let link = link {
            openURL(link)
        }
    }
    func openURL(_ link: String) {
        let URL = Foundation.URL(string: "http://\(link.uppercased())")!
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.openURL(URL)
        }
    }
}

extension TopFeedCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        
        if scrollView.isDragging || scrollView.isDecelerating {
            let page = scrollView.contentOffset.x / scrollView.bounds.width
            pageControl.setCurrentPage(page)
            setNews(newsFeed: topNewsFeed[pageControl.currentPage])
        }
    }
}
