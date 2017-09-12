//
//  API.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation
import tmdbAPI

class API {
	
	let endpoint: URL
	let apiKey: String
	
	public init(endpoint: URL, apiKey: String) {
		self.endpoint = endpoint
		self.apiKey = apiKey
	}
	
	// MARK: - Public methods

	func fetch(request: DiscoverRequest, completion: @escaping ([TMDB.Movie]) -> Void) {
		let api = tmdbAPI.API(endpoint: endpoint, apiKey: apiKey)
		api.send(request: request) { (movies, error) in
			var convertedMovies = [Movie]()
			
			if let error = error {
				completion(convertedMovies)
				NSLog("Fetch error: %@", error.localizedDescription)
				return
			}
			
			guard let movies = movies else {
				completion(convertedMovies)
				return
			}
			
			for apiMovie in movies {
				convertedMovies += [self.convert(apiMovie: apiMovie)]
			}
			
			completion(convertedMovies)
		}
	}
	
	// MARK: - Private methods
	
	
	private func convert(apiMovie: tmdbAPI.Movie) -> TMDB.Movie {
		let posterPath = Constants.posterURLPrefix.appendingPathComponent(apiMovie.posterRelativePath)
		return TMDB.Movie(title: apiMovie.originalTitle, posterPath: posterPath)
	}
	
}
