//
//  Utilities.swift
//  News
//
//  Created by Sasha Voloshanov on 4/16/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func eBlueColor() -> UIColor {
        return UIColor(red: 0, green: 173 / 255.0, blue: 239 / 255.0, alpha: 1.0)
    }
}

extension String {
    static func getURLToShow(fromURL urlString: String?) -> String? {
        let urlWithoutHHTP = urlString!.components(separatedBy: "//")
        let url = urlWithoutHHTP.last!.components(separatedBy: "/")
        let urlWithoutWWW = url.first!.components(separatedBy: "www.").last!
        
        let domainNameAndTopLevel = urlWithoutWWW.components(separatedBy: ".")
        let domainName = domainNameAndTopLevel.first!.capitalized
        let topLevelDomain = domainNameAndTopLevel.last!
        let linkToShow = "\(domainName).\(topLevelDomain)"
        
        return linkToShow
    }
}

extension Date {
    static func secondsSinceDate(_ createdAt: String) -> Int {
        let components = (Calendar.current as NSCalendar).components([.second], from: Date(), to: dateFromString(createdAt), options: [])
        return abs(components.second!)
    }
    
    static func minutesSinceDate(_ createdAt: String) -> (Int, String) {
        let components = (Calendar.current as NSCalendar).components([.minute], from: Date(), to: dateFromString(createdAt), options: [])
        return (abs(components.minute!), "\(abs(components.minute as! Int)) minutes ago")
    }
    
    static func hoursSinceDate(_ createdAt: String) -> (Int, String) {
        let components = (Calendar.current as NSCalendar).components([.hour], from: Date(), to: dateFromString(createdAt), options: [])
        return (abs(components.hour!), "\(abs(components.hour as! Int)) hours ago")
    }
    
    static func daysSinceDate(_ createdAt: String) -> (Int, String) {
        let components = (Calendar.current as NSCalendar).components([.day], from: Date(), to: dateFromString(createdAt), options: [])
        return (abs(components.day!), "\(abs(components.day as! Int)) days ago")
    }
    
    static func weeksSinceDate(_ createdAt: String) -> (Int, String) {
        let components = (Calendar.current as NSCalendar).components([.weekOfMonth], from: Date(), to: dateFromString(createdAt), options: [])
        return (abs(components.weekOfMonth!), "\(abs(components.weekOfMonth as! Int)) days ago")
    }
    
    static func monthsSinceDate(_ createdAt: String) -> (Int, String) {
        let components = (Calendar.current as NSCalendar).components([.month], from: Date(), to: dateFromString(createdAt), options: [])
        
        return (abs(components.month!), "\(abs(components.month as! Int)) days ago")
    }
    
    static func yearsSinceDate(_ createdAt: String) -> (Int, String) {
        let components = (Calendar.current as NSCalendar).components([.year], from: Date(), to: dateFromString(createdAt), options: [])
        
        return (abs(components.year!), "\(abs(components.year as! Int)) days ago")
    }
    
    
    fileprivate static func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateFromString = dateFormatter.date(from: dateString)!
        
        return dateFromString
    }
}

