//
//  MovieAPIManager.swift
//  BT-Flix
//
//  Created by Teran on 12/18/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import Foundation


class MovieAPIManager {
    fileprivate var apiKey           = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    fileprivate var requestString    = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    fileprivate var basePosterPath   = "https://image.tmdb.org/t/p/w500"
    fileprivate var baseBackdropPath = "https://image.tmdb.org/t/p/w1280"
    fileprivate var requestURL: URL?
    
    
    fileprivate var currentPageCount: Int = 0
    
    
    public init() {
        self.currentPageCount += 1
        self.requestURL = URL(string: requestString + apiKey + "&page=\(currentPageCount)")
    }
    
    
    public func increasePageCount() {
        self.currentPageCount += 1
    }
    
    
    public func requestMovies(finishedFetching: @escaping ( ([Movie]) -> Void) ) {
        var movies = [Movie]()
        
        let request = URLRequest(url: requestURL!)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (taskData, taskResponse, taskError) in
            if let error = taskError {
                print(error.localizedDescription)
            }
            else if let data = taskData {
                let dataDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
//                print(dataDict)
                let movieDictArray = dataDict["results"] as! [[String : Any]]
                
                for movieDict in movieDictArray {
                    let movie = self.getMovie(from: movieDict)
                    movies.append(movie)
                }
            }
            
            finishedFetching(movies)
        }
        
        task.resume()
    }
    
    
    private func getMovie(from dict: [String: Any]) -> Movie {
        let title        = dict["title"] as! String
        let overview     = dict["overview"] as! String
        let releaseDate  = dict["release_date"] as! String
        let rating       = dict["vote_average"] as! Double
        let posterPath   = dict["poster_path"] as! String
        let backdropPath = dict["backdrop_path"] as! String
//        let backdropSizes = dict["backdrop_sizes"] as! [String]
//        print(backdropSizes)
        let movie = Movie(title: title, overview: overview, releaseDate: releaseDate, rating: rating, posterPath: posterPath, backdropPath: backdropPath)
        
//        print("Title: \(movie.getTitle()) ____ Release Date: \(movie.getReleaseDate()) ____ Poster Path: \(movie.getPosterPath()) ____ Overview: \(movie.getOverview())\n\n\n")
        
        return movie
    }
    
    
    public func getPosterImageURLPath(with path: String) -> String {
        return basePosterPath + path
    }
    
    
    public func getBackdropImagePath(with path: String) -> String {
        return baseBackdropPath + path
    }
}
