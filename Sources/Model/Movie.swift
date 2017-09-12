//
//  Movie.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

class Movie {
	
	let title: String
	let posterPath: URL
	var posterImage: UIImage? = nil
	
	init(title: String, posterPath: URL) {
		self.title = title
		self.posterPath = posterPath
	}
	
}
