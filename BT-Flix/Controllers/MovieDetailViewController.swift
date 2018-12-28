//
//  MovieDetailViewController.swift
//  BT-Flix
//
//  Created by Teran on 12/27/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var backdropImageView : UIImageView!
    @IBOutlet weak var titleLabel        : UILabel!
    @IBOutlet weak var overviewLabel     : UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel  : UILabel!
    @IBOutlet weak var yearLabel : UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var rtomRatingLabel: UILabel!
    
    public var movie : Movie!
    public var fullBackdropPath : String!
    public var fullPosterPath   : String!
    
    
    private var omdbManager = OmdbAPIManager()
    private var movieInfo: OmdbInfo! {
        didSet {
            imdbRatingLabel.text = movieInfo.imdbRating
            rtomRatingLabel.text = movieInfo.rtomRating
        }
    }
    
    
    public func setBackdropImage() {
        let url = URL(string: self.fullBackdropPath)
        backdropImageView.af_setImage(withURL: url!)
    }
    
    
    private func setupSubViews() {
        titleLabel.text    = movie.getTitle()
        let releaseDate    = movie.getReleaseDate()
        monthLabel.text    = releaseDate.month.uppercased()
        dayLabel.text      = "\(releaseDate.day)"
        yearLabel.text     = "\(releaseDate.year)"
        overviewLabel.text = movie.getOverview()
        self.setBackdropImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.omdbManager.requestInfo(for: movie.getTitle()) { (fetchedInfo) in
            self.movieInfo = fetchedInfo
        }
        self.setupSubViews()
        self.backdropImageView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 3).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
