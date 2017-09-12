//
//  Movie.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

public struct Movie {
	
	public let voteCount: Int
	public let posterRelativePath: String
	public let originalTitle: String
	
	init?(json: [String: Any]) {
		guard let title = json["original_title"] as? String,
			let posterPath = json["backdrop_path"] as? String,
			let voteCount = json["vote_count"] as? Int else { return nil }
		
		self.originalTitle = title
		self.posterRelativePath = posterPath
		self.voteCount = voteCount
	}
	
}
