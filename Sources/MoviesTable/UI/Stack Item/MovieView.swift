//
//  MovieView.swift
//  TMDB
//
//  Created by Vasily Ulianov on 11/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

class MovieView: UIView {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var movieImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()

		movieImageView.layer.cornerRadius = 4.0
		movieImageView.clipsToBounds = true
	}
	
	func display(movie: Movie) {
		nameLabel.text = movie.title
		movieImageView.image = movie.posterImage
	}
	
	class func instanceFromNib() -> MovieView {
		return UINib(nibName: "MovieView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MovieView
	}
	
}
