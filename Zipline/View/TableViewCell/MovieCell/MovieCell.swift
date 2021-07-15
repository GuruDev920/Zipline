//
//  MovieCell.swift
//  Zipline
//
//  Created by Sun on 2021/7/15.
//

import UIKit
import Cosmos

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var cover_img: UIImageView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var rating_view: CosmosView!
    @IBOutlet weak var release_date_lbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        init_UI()
    }
    
    var movie: Movie! = nil {
        didSet {
            cover_img.kf_setImage(movie.poster_path, "404")
            title_lbl.text = movie.title
            rating_view.rating = movie.vote_average
            release_date_lbl.text = movie.release_date
        }
    }
    
    func init_UI() {
        rating_view.settings.updateOnTouch = false
        rating_view.settings.fillMode = .precise
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
