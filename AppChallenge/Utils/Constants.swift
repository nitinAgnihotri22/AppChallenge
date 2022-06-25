//
//  Constants.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import Foundation


struct APIUrl {
    static let baseUrl = "http://www.omdbapi.com/"
}

func getSearchUrl(_ searchStr:String,
                  _ page:Int = 1) -> String {
    
    let query = "\(APIUrl.baseUrl)?apikey=\(AppKeys.omdbKey)&s=\(searchStr)&page=\(page)&type=movie"
    return query
}

func getMovieDetailUrl(_ movieId:String) -> String {
    
    ///http://www.omdbapi.com/?i=tt4189022&apikey=148f6d20
    let query = "\(APIUrl.baseUrl)?i=\(movieId)&apikey=\(AppKeys.omdbKey)"
    return query
}
