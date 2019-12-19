//
//  AppConstants.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 16/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import Foundation
import UIKit

class AppConstants{
    
    static let APP_KEY          = "1a1f6931f302763dfa89ada35b961a77"
    static let ULR_SCHEMA       = "https"
    static let URL_HOST         = "api.themoviedb.org"
    static let URL_NOW_PLAYING  = "/3/movie/now_playing"
    static let URL_SEARCH       = "/3/search/movie"
    static let URL_QUERY_PAGE   = "page"
    static let URL_QUERY_QUERY  = "query"
    static let URL_ATTRIBUTES: [String: String] = [ "api_key" : APP_KEY ]
    static let URL_QUERY_MIN_LENGTH = 3
    
    static let LIST_FILM_CELL_HEIGTH: CGFloat = 55
    
    static let LIST_FILM_PAGE_TIME_INTERVAL = 0.5
    
}
