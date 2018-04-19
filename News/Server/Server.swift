//
//  Server.swift
//  News
//
//  Created by Sasha Voloshanov on 4/12/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import Foundation

class Server: NSObject {
    static let basicRequestURL = "http://allcom.lampawork.com/api/v1.0/products/"

    struct Keys {
        static let image       = "image"
        static let name        = "name"
        static let imageURL    = "url"
        static let date        = "id"
        static let next        = "next"
        static let top         = "top"
        static let results     = "results"
    }
}
