//
//  MoviesFetcher.swift
//  TMDB
//
//  Created by Vasily Ulianov on 18/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

protocol MoviesFetcherDelegate: class {
	func updated(movies: [Movie], type: MoviesFetcher.MovieType)
}

class MoviesFetcher {

	enum MovieType {
		case inTheatres, popular, highestRated
	}
	
	unowned let delegate: MoviesFetcherDelegate
	
	init(delegate: MoviesFetcherDelegate) {
		self.delegate = delegate
	}

	func fetchData() {
		let config = TMDBConfigurationReader.read()
		let api = API(endpoint: config.endpoint, apiKey: config.token)
		
		ActivityIndicator.start(activities: 3)
		
		api.fetch(request: APIRequest.inTheatres) { [weak self] in
			self?.delegate.updated(movies: $0, type: .inTheatres)
			ActivityIndicator.stop()
		}
		
		api.fetch(request: APIRequest.popular) { [weak self] in
			self?.delegate.updated(movies: $0, type: .popular)
			ActivityIndicator.stop()
		}
		
		api.fetch(request: APIRequest.highestRated) { [weak self] in
			self?.delegate.updated(movies: $0, type: .highestRated)
			ActivityIndicator.stop()
		}
	}
	
}
