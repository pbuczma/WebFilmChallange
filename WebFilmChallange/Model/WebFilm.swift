//
//  WebFilm.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 16/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import Foundation


struct WebFilmResults: Codable{

    let results: [WebFilm]
    let page: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey{
        case results = "results"
        case page    = "page"
        case totalPages = "total_pages"
    }
    
    
    init( results: [WebFilm], page: Int, totalPages: Int ){
        self.results    = results
        self.page       = page
        self.totalPages = totalPages
    }
    
    
    init(from decoder: Decoder) throws {
    
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = try container.decode([WebFilm].self, forKey: .results)
        self.page    = try container.decode(Int.self, forKey: .page)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    }

}




struct WebFilm: Codable {
    
    let id:Int
    let title: String
    let releaseDate: Date?
    let overview: String
    let averageVote: Double
    let backdropPath: String?
        
    static let dateFormatter = { () -> DateFormatter in
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
    enum CodingKeys: String, CodingKey{
        
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case overview = "overview"
        case averageVote = "vote_average"
        case backdropPath = "backdrop_path"
        
        
    }
    
    
    init(id: Int, title: String, releaseDate: Date, overview: String, averageVote: Double, backdropPath: String? ){
        
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.averageVote = averageVote
        self.backdropPath = backdropPath
    
    }
    
    init(from decoder: Decoder) throws {
           
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        let id = try container.decode(Int.self, forKey: .id)
    
        let title = try container.decode(String.self, forKey: .title)
        
        let overview = try container.decode(String.self, forKey: .overview)
    
        let backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        
        let averageVote = try container.decode(Double.self, forKey: .averageVote)
        
        let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        
        var releaseDate: Date?
        
        if releaseDateString != nil {
            releaseDate = WebFilm.dateFormatter.date(from: releaseDateString!)
        }
           
        self.id = id
        self.title = title
        self.overview = overview
        self.averageVote = averageVote
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
   
    }
     
}
         
