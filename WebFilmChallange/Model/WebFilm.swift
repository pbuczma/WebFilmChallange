//
//  WebFilm.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 16/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import Foundation


struct WebFilmResults: Codable{

    let results: [WebFilm]?
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
        
        self.results = try container.decodeIfPresent([WebFilm].self, forKey: .results)
        self.page    = try container.decode(Int.self, forKey: .page)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    }

}




struct WebFilm: Codable {
    
    let id:Int
    let title: String
    let releaseDate: Date?
    let overview: String
    let averageVote: Double?
    let posterPath: String?
    var favourie = false
        
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
        case posterPath = "poster_path"
        
        
    }
    
    
    init(id: Int, title: String, releaseDate: Date, overview: String, averageVote: Double, posterPath: String?){
        
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.averageVote = averageVote
        self.posterPath = posterPath
    
    }
    
    init(from decoder: Decoder) throws {
        
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
            
        do{
            self.id = try container.decode(Int.self, forKey: .id)
        }catch DecodingError.typeMismatch{
            throw DecodingError.typeMismatch(WebFilm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded id not of an expected type for 'id'"))
        }
            
        
        do {
    
            self.title = try container.decode(String.self, forKey: .title)
        }catch DecodingError.typeMismatch{
            throw DecodingError.typeMismatch(WebFilm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded id not of an expected type for 'title'"))
        }
        
        do{
        
            let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate)
            
            if releaseDateString != nil {
                self.releaseDate = WebFilm.dateFormatter.date(from: releaseDateString!)
            }else{
                throw DecodingError.typeMismatch(WebFilm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded id not of an expected type for 'releaseDate'"))
            }
            
        }catch DecodingError.typeMismatch{
            throw DecodingError.typeMismatch(WebFilm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded id not of an expected type for 'releaseDate'"))
        }
        
        
        do {
            self.overview = try container.decode(String.self, forKey: .overview)
        }catch DecodingError.typeMismatch{
            throw DecodingError.typeMismatch(WebFilm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded id not of an expected type for 'overview'"))
        }
    
        do{
            self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        }catch DecodingError.typeMismatch{
            throw DecodingError.typeMismatch(WebFilm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded id not of an expected type for 'posterPath'"))
        }
        
        
        
        do{
            self.averageVote = try container.decodeIfPresent(Double.self, forKey: .averageVote) ?? 0.0
        }catch DecodingError.typeMismatch{
            throw DecodingError.typeMismatch(WebFilm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded id not of an expected type for 'averageVote'"))
        }
    
    }
     
}
         
extension WebFilm: Equatable {
    
    static func ==(lhs: WebFilm, rhs: WebFilm) -> Bool {
        return lhs.id == rhs.id
    }
    
}
