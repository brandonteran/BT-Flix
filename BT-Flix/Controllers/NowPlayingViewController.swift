//
//  NowPlayingViewController.swift
//  BT-Flix
//
//  Created by Teran on 12/18/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    @IBOutlet weak var nowPlayingTableView: UITableView!
    private var refreshControl = UIRefreshControl()
    
//    fileprivate var fetchingMore = false
    
    fileprivate var apiManager = MovieAPIManager()
    fileprivate var movies = [Movie]() {
        didSet {
            self.nowPlayingTableView.reloadData()
        }
    }
    
    
    @objc private func refreshTableView() {
        self.apiManager.requestMovies(finishedFetching: { (requestedMovies) in
            self.movies = requestedMovies
            self.nowPlayingTableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    
//    private func fetchMoreMovies() {
//        fetchingMore = true
//        print("Fetching more")
//        apiManager.requestMovies { (fetchedMovies) in
//            self.movies.append(contentsOf: fetchedMovies)
//            self.nowPlayingTableView.reloadData()
//        }
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1462399662, green: 0.1462444067, blue: 0.1462419927, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        self.nowPlayingTableView.addSubview(refreshControl)
        self.nowPlayingTableView.delegate   = self
        self.nowPlayingTableView.dataSource = self
        self.nowPlayingTableView.rowHeight  = UITableView.automaticDimension
        self.nowPlayingTableView.estimatedRowHeight = 160
        
        self.apiManager.requestMovies(finishedFetching: { (requestedMovies) in
            self.movies = requestedMovies
            self.nowPlayingTableView.reloadData()
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let lastSelectedRow = nowPlayingTableView.indexPathForSelectedRow {
            nowPlayingTableView.deselectRow(at: lastSelectedRow, animated: false)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1462399662, green: 0.1462444067, blue: 0.1462419927, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = nowPlayingTableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            
            let destinationVC    = segue.destination as! MovieDetailViewController
            let fullPosterPath   = apiManager.getPosterImageURLPath(with: movie.getPosterPath())
            let fullBackdropPath = apiManager.getBackdropImagePath(with: movie.getBackdropPath())
            
            destinationVC.movie = movie
            destinationVC.fullBackdropPath = fullBackdropPath
            destinationVC.fullPosterPath   = fullPosterPath
        }
    }
}


extension NowPlayingViewController: UITableViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.height * 4 {
//            if !fetchingMore {
//                fetchMoreMovies()
//            }
//        }
//    }
}


extension NowPlayingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell
        
        let movie = movies[indexPath.item]
        let currentPosterPath = movie.getPosterPath()
        
        cell.movie = movie
        cell.setPosterImage(with: apiManager.getPosterImageURLPath(with: currentPosterPath))
        
        return cell
    }
    
    
}
