//
//  WebFileFactory.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 16/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import Foundation


enum WebFilmProxyError: Error{
    
    case EmptyURL
    case URLCouldNotBeCreated
    
}


class WebFilmProxy {
    
    let urlSession: URLSession

    let jsonDecoder = JSONDecoder()
    var urlSessionTasks: [URLSessionTask] = []
    var nowPlayingPages: [Int] = []
    var searchMoviePages: [Int] = []
    var nowPayingTotalPages = 1
    var searchMovieTotalPages = 1
    var nowPlayingWebFilm: [WebFilm] = []
    var searchMovieWebFilm: [WebFilm] = []
    
    var nowPlayingSemaphore = DispatchSemaphore(value: 1)
    var serachMovieSemaphore   = DispatchSemaphore(value: 1)
    
    var searchMovieQuery = ""{
        didSet{
            //searchMoviePages.removeAll()
            //searchMovieWebFilm.removeAll()
        }
    }
    
    
    
    init( urlSession: URLSession ){
        
        self.urlSession = urlSession
        
    }

    
    func hasNextNowPlayingFilm() -> Bool {
        
        var hasNext = false
        
        nowPlayingSemaphore.wait()
        
        let lastPage = self.nowPlayingPages.last
        
        if  lastPage == nil {
            hasNext = true
        }else{
            
            if lastPage! == nowPayingTotalPages {
                hasNext = false
            }else{
                hasNext = true
            }
        }
        
        nowPlayingSemaphore.signal()
        
        return hasNext
        
    }
    
    func hasNextSearchMovie() -> Bool {
        
        var hasNext = false
        
        serachMovieSemaphore.wait()
    
        
        let lastPage = self.searchMoviePages.last
        
        if lastPage == nil {
            hasNext = true
        }else{
            
            if lastPage! == searchMovieTotalPages {
                hasNext = false
            }else{
                hasNext = true
            }
        }
        
        serachMovieSemaphore.signal()
        
        
        return hasNext
    }
    
    
    
    
    /* if last page is return function returns false */
    func nextNowPlayingFilm( completion: @escaping( _ webFilm: [WebFilm], _ error: Error? ) -> Void ) -> Void  {
    
        var nextPage = 1
        
        
        if !hasNextNowPlayingFilm() {
            nowPlayingSemaphore.signal()
            completion( [WebFilm](), nil)
        }
        
        nowPlayingSemaphore.wait()
        
        if nowPlayingPages.count > 0 {
            nextPage = nowPlayingPages.last! + 1
        }
        
        nowPlayingSemaphore.signal()
        
        return getNowPlayingFilm(page: nextPage) { [weak self] (_webFilm, _error) in
            self?.nowPlayingWebFilm.append(contentsOf: _webFilm)
            completion(_webFilm, _error)
        }
    
    
    }
    
    
    func nextSearchMovieFilm(query: String, completion: @escaping( _ webFilm: [WebFilm], _ error: Error? ) -> Void ) -> Void  {
        
        var nextPage = 1
        
        self.searchMovieQuery = query
        
        if !hasNextSearchMovie(){
            serachMovieSemaphore.signal()
            completion( [WebFilm](), nil )
        }
        
        serachMovieSemaphore.wait()
        
        if searchMoviePages.count > 0 {
            nextPage = searchMoviePages.last! + 1
        }
        
        serachMovieSemaphore.signal()
        
        return getSearchMovie(query: query, page: nextPage) { [weak self] (_webFilm, _error) in
            self?.searchMovieWebFilm.append(contentsOf: _webFilm)
            completion(_webFilm, _error)
        }
        
    }
    
    
    
    private func getNowPlayingFilm( page: Int?, completion: @escaping( _ webFilm: [WebFilm], _ error: Error? ) -> Void ) -> Void {
        
        var webFilm: [WebFilm] = []
        var error: Error?
        
        
        let urlString = URLHelper.urlForNowPalying(page: page)
        
        if urlString == nil {
            error = WebFilmProxyError.EmptyURL
            completion( webFilm, error )
        }
        
        let url = URL(string: urlString!)
        
        if url == nil {
            error = WebFilmProxyError.URLCouldNotBeCreated
            completion(webFilm, error)
        }
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: 6000)
        
        self.nowPlayingSemaphore.wait()
        let task = urlSession.dataTask(with: request, completionHandler: { [weak self] (data, response, _error) in
        
            if error == nil{
                do {
                    let queryResults = try self?.jsonDecoder.decode(WebFilmResults.self, from: data!)
                    if queryResults != nil {
                        webFilm = queryResults!.results
                        self?.nowPayingTotalPages = queryResults!.totalPages
                        let page = queryResults!.page
                        self?.nowPlayingPages.append(page)
                    }
                }catch{
                    print("WebFilmProxy-getNowPlayingFilm: \(error)")
                }
            }else{
                error = _error
            }
            self?.nowPlayingSemaphore.signal()
            completion(webFilm, error)
        })
        task.resume()
        urlSessionTasks.append(task)
    }
    
    
    private func getSearchMovie( query: String, page: Int?, completion: @escaping( _ webFilm: [WebFilm], _ error: Error? ) -> Void ) -> Void {
        
        var webFilm: [WebFilm] = []
        var error: Error?
        
        
        let urlString = URLHelper.searchMovie(query: query, page: page)
        
        if urlString == nil {
            error = WebFilmProxyError.EmptyURL
            completion( webFilm, error )
        }
        
        let url = URL(string: urlString!)
        
        if url == nil {
            error = WebFilmProxyError.URLCouldNotBeCreated
            completion(webFilm, error)
        }
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: 6000)
        
        self.serachMovieSemaphore.wait()
        let task = urlSession.dataTask(with: request, completionHandler: { [weak self] (data, response, _error) in
        
            if error == nil{
                do {
                    let queryResults = try self?.jsonDecoder.decode(WebFilmResults.self, from: data!)
                    if queryResults != nil {
                        webFilm = queryResults!.results
                        self?.searchMovieTotalPages  = queryResults!.totalPages
                        let page = queryResults!.page
                        self?.searchMoviePages.append(page)
                    }
                    
                }catch{
                    print("WebFilmProxy-getSearchMovie: \(error)")
                }
            }else{
                error = _error
            }
            self?.serachMovieSemaphore.signal()
            completion(webFilm, error)
        })
        task.resume()
        urlSessionTasks.append(task)
    }
    
    
}



