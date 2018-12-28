//
//  NowPlayingCell.swift
//  BT-Flix
//
//  Created by Teran on 12/18/18.
//  Copyright © 2018 BT Apps. All rights reserved.
//

import UIKit
import AlamofireImage


class NowPlayingCell: UITableViewCell {
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var ratingLabel      : UILabel!
    @IBOutlet weak var releaseDateLabel : UILabel!
    @IBOutlet weak var posterImageView  : UIImageView!
    
    
    public var movie: Movie! {
        didSet {
            titleLabel.text       = movie.getTitle()
            let releaseDate = movie.getReleaseDate()
            releaseDateLabel.text = "\(releaseDate.month.uppercased()) \(releaseDate.day), \(releaseDate.year)"
            ratingLabel.text    = "AVERAGE RATING:  \(movie.getRating())"
        }
    }
    
    
    public func setPosterImage(with path: String) {
        let url = URL(string: path)
        posterImageView.af_setImage(withURL: url!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
