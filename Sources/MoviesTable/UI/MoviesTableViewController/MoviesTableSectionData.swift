//
//  MoviesTableSectionData.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

/// Model for `MoviesTableViewController`
class MoviesTableSectionData {
	
	var movies = [Movie]()
	let title: String
	
	init(title: String) {
		self.title = title
	}
	
}
