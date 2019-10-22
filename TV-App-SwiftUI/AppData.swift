//
//  AppData.swift
//  TV App
//
//  Created by Bindu on 15/06/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import UIKit

struct AppData {
    static let baseUrl = "https://api.tvmaze.com"
    static let search = "/search/shows"
    static let show = "/show/"
    static let shows = "/shows/"
    static let episodes = "/episodes"
    static let season = "/seasons"
    static let cast = "/cast"
    static let crew = "/crew"
    static let placeholderUrl = "http://via.placeholder.com/350/ffffff/000000?text=Image+Not+found"
    static let dateFormat = "dd MMM yyyy"
    static let dateFormatApi = "yyyy-MM-dd"
    
}


enum AppError : Error {
    case invalidFormat
}
