//
//  WebFilmChallangeTests.swift
//  WebFilmChallangeTests
//
//  Created by Zespół ds Środowiska Pracy IT on 16/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import XCTest
@testable import WebFilmChallange

class WebFilmChallangeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testURLHelperNowPalying(){
        
        
        let page = 2
        
        let url = URLHelper.urlForNowPalying(page: page)
        
        if url != nil {
            print(url!)
        }
        
    }
    
    
    func testURLHelperSearchMovie(){
        
        let query = "odys e"
        
        let url = URLHelper.searchMovie(query: query, page : 2)
        
        if url != nil {
            print(url!)
        }
        
    }

    
    func testWebFilmGetNowPlayingFilm(){
        
        
        
        let webFilmProxy = WebFilmProxy(urlSession: getURLSession() )
        
        var webFilm: [WebFilm] = []
        var error: Error?
        
        for i in 0...15{
        
            print("processing page: \(i)")
            let expectation = self.expectation(description: "testGetNowPlayingFilm")
            
            webFilmProxy.nextNowPlayingFilm( completion: { ( _webFilm, _error) in
            
                webFilm =  _webFilm
                error = _error
                
                expectation.fulfill()
            })
        
            waitForExpectations(timeout: 15, handler: nil)
            print("count: \(webFilm.count) \(webFilmProxy.nowPayingTotalPages)")
           
            
            XCTAssertNil(error)
            if i < webFilmProxy.nowPayingTotalPages {
                XCTAssertGreaterThan(webFilm.count, 0)
            }else{
                XCTAssertEqual(webFilm.count, 0)
            }
            
        }
        
    
    }
    
    
    func testNextSearchMovie(){
        
        
        
        let webFilmProxy = WebFilmProxy( urlSession: getURLSession() )
        
        var webFilm: [WebFilm] = []
        var error: Error?
        
        var query = "odysse"  //"odyssey"
        
        for i in 0...5 {
        
            let expectation = self.expectation(description: "testGetSearchMovie")
            webFilmProxy.nextSearchMovieFilm(query: query) { (_webFilm, _error) in
                
                webFilm = _webFilm
                error = _error
                expectation.fulfill()
            }
            
            if i == 5 {
                query = "odyssey"
            }
            
            waitForExpectations(timeout: 15, handler: nil)
            print("count: \(webFilm.count)")
            XCTAssertNil(error)
            
            /*for film in webFilm {
                print( film.title )
            }*/
            
            
            if i < webFilmProxy.searchMovieTotalPages{
                XCTAssertGreaterThan(webFilm.count, 0)
            }else{
                XCTAssertEqual(webFilm.count, 0)
            }
           
        }
        
        
    }
    
    
    func testFavouriteWebFilm(){
        
        
        let arrayOfInt = [ 2, 3, 5, 6 ]
        let favourite = FavouriteWebFilm(favourite: arrayOfInt)
        
        FavouriteWebFilm.saveFavourite(appRights: favourite)
        
        let favourite2 = FavouriteWebFilm.loadFavourite()
        
        XCTAssertNotNil(favourite2)
        
        for i in 0..<arrayOfInt.count{
            XCTAssertEqual(favourite.favourite[i], favourite2!.favourite[i])
        }
        
        var webFilm = WebFilm(id: 10, title: "eee", releaseDate: Date(), overview: "ddd", averageVote: 0.0, posterPath: nil)
        
        webFilm.favourie = true
        let isFav = favourite.isFavourite(webFilm: webFilm)
        
        XCTAssertEqual(isFav, false)
        
        
        favourite.modifyFavourite(webFilm: webFilm)
        
        let isFav2 = favourite.isFavourite(webFilm: webFilm)
        
        //after adding WebFilm
        XCTAssertEqual(isFav2, true)
        
        
        //after removing WebFilm
        webFilm.favourie = false
        favourite.modifyFavourite(webFilm: webFilm)
        
        
        let isFav3 = favourite.isFavourite(webFilm: webFilm)
        
        XCTAssertEqual(isFav3, false)
        
    }
    
    
    
    
    private func getURLSession() -> URLSession{
        
        let defaultSession = URLSession(configuration: .default)
        
        return defaultSession
        
    }
    
    
    
    
}
