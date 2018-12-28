//
//  Movie.swift
//  BT-Flix
//
//  Created by Teran on 12/18/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//


import Foundation


public struct MovieDate {
    var month : String
    var day   : Int
    var year  : Int
    
    init(formattedDate: String) {
        let dateArr = formattedDate.split(separator: "|")
        self.month  = String(dateArr[0])
        self.day    = Int(dateArr[1])!
        self.year   = Int(dateArr[2])!
    }
}


class Movie {
    private var title        : String
    private var overview     : String
    private var releaseDate  : MovieDate
    private var rating       : Double
    private var posterPath   : String
    private var backdropPath : String
    
    init(title: String, overview: String, releaseDate: String, rating: Double, posterPath: String, backdropPath: String) {
        self.title        = title
        self.releaseDate  = getFormattedDate(dateString: releaseDate)
        self.rating       = rating
        self.overview     = overview
        self.posterPath   = posterPath
        self.backdropPath = backdropPath
    }
    
    public func getTitle() -> String {
        return self.title
    }
    
    public func getOverview() -> String  {
        return self.overview
    }
    
    public func getReleaseDate() -> MovieDate  {
        return self.releaseDate
    }
    
    public func getRating() -> Double {
        return self.rating
    }
    
    public func getPosterPath() -> String  {
        return self.posterPath
    }
    
    public func getBackdropPath() -> String  {
        return self.backdropPath
    }
}


fileprivate func getFormattedDate(dateString: String) -> MovieDate {
    let dateFormatterGet        = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    
    let formattedDate        = DateFormatter()
    formattedDate.dateFormat = "MMM|dd|yyyy"
    
    let date      = dateFormatterGet.date(from: dateString)
    let eventDate = MovieDate(formattedDate: formattedDate.string(from: date!))
    
    return eventDate
}

