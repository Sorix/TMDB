//
//  MovieRequest.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

public class DiscoverRequest: RequestModel {
	
	public typealias AnswerModel = [Movie]
	
	public var method = "discover/movie"
	public var parameters = [
		"sort_by": "popularity.desc"
	]
	
	public func format(json: [String : Any]) -> AnswerModel? {
		guard let results = json["results"] as? NSArray else { return nil }
		
		var movies = [Movie]()
		
		for movieItem in results {
			guard let movieDictionary = movieItem as? [String: Any],
				let movie = Movie(json: movieDictionary) else { continue }
			
			movies.append(movie)
		}
		
		return movies
	}
	
	public init() { }
	
}
