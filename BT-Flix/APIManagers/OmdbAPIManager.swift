//
//  OmdbAPIManager.swift
//  BT-Flix
//
//  Created by Teran on 12/28/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import Foundation


class OmdbAPIManager {
    fileprivate var apiKey           = "5fbc8db5"
    fileprivate var requestString    = "http://www.omdbapi.com/?i=tt3896198&apikey="
    fileprivate var requestURLString : String!
    fileprivate var requestURL       : URL?
    
    
    public init() {
        self.requestURLString = requestString + apiKey + "&t="
    }
    
    
    public func requestInfo(for title: String, finishedFetching: @escaping ( (OmdbInfo) -> Void) ) {
        let title = title.replacingOccurrences(of: " ", with: "%20")
        var movieInfo = OmdbInfo(imdbRating: "N/A", rtomRating: "N/A")
        self.requestURL = URL(string: requestURLString + title)
        let request = URLRequest(url: requestURL!)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (taskData, taskResponse, taskError) in
            if let error = taskError {
                print(error.localizedDescription)
            }
            else if let data = taskData {
                let dataDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                if dataDict.index(forKey: "imdbRating") != nil {
                    let imdbRating = dataDict["imdbRating"] as! String
                    movieInfo.imdbRating = imdbRating
                }
                
                if dataDict.index(forKey: "Ratings") != nil {
                    let ratings = dataDict["Ratings"] as! [[String : Any]]
                    if ratings.count >= 3 {
                        let rtRating = ratings[1]
                        let rtomRating = rtRating["Value"] as! String
                        movieInfo.rtomRating = rtomRating
                    }
                }
            }
            
            finishedFetching(movieInfo)
        }
        
        task.resume()
    }
    
    
//    private func getMovie(from dict: [String: Any]) -> Movie {
//        let title        = dict["title"] as! String
//        let overview     = dict["overview"] as! String
//        let releaseDate  = dict["release_date"] as! String
//        let rating       = dict["vote_average"] as! Double
//        let posterPath   = dict["poster_path"] as! String
//        let backdropPath = dict["backdrop_path"] as! String
//        //        let backdropSizes = dict["backdrop_sizes"] as! [String]
//        //        print(backdropSizes)
//        let movie = Movie(title: title, overview: overview, releaseDate: releaseDate, rating: rating, posterPath: posterPath, backdropPath: backdropPath)
//
//        //        print("Title: \(movie.getTitle()) ____ Release Date: \(movie.getReleaseDate()) ____ Poster Path: \(movie.getPosterPath()) ____ Overview: \(movie.getOverview())\n\n\n")
//
//        return movie
//    }
}
