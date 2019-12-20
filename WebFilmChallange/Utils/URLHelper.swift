//
//  URLHelper.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 16/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

class URLHelper {
    
    
    static func urlForNowPalying( page: Int? ) -> String? {
        
        var queryParams: [String: String] = AppConstants.URL_ATTRIBUTES
        
        if page != nil {
            queryParams[AppConstants.URL_QUERY_PAGE] = "\(page!)"
        }
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = AppConstants.ULR_SCHEMA
        urlComponents.host = AppConstants.URL_HOST
        urlComponents.path = AppConstants.URL_NOW_PLAYING
        urlComponents.setQueryItems(with: queryParams)
        
        
        //print(urlComponents.url?.absoluteString)
        
        return urlComponents.url?.absoluteString
        
    }
    
    
    static func searchMovie(query: String, page: Int?) -> String? {
        
        var queryParams: [String: String] = AppConstants.URL_ATTRIBUTES
        
        queryParams[AppConstants.URL_QUERY_QUERY] = query
        
        
        if page != nil {
            queryParams[AppConstants.URL_QUERY_PAGE] = "\(page!)"
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = AppConstants.ULR_SCHEMA
        urlComponents.host = AppConstants.URL_HOST
        urlComponents.path = AppConstants.URL_SEARCH
        urlComponents.setQueryItems(with: queryParams)
        
        
        return urlComponents.url?.absoluteString
        
    }
    
    
    static func posterURL( posterSuffix: String ) -> String? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = AppConstants.ULR_SCHEMA
        urlComponents.host = AppConstants.URL_IMG_HOST
        urlComponents.path = AppConstants.URL_IMG_QUERY + posterSuffix
        
        return urlComponents.url?.absoluteString
    
    }
    
    
}
