//
//  TMDBConfigurationReader.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

class TMDBConfigurationReader {
	
	/// Read from plist file TMDB API configuration
	///
	/// - Returns: api_key and endpoint URL
	static func read() -> (token: String, endpoint: URL) {
		guard
			let path = Bundle.main.path(forResource: Constants.tmdbPlistName, ofType: "plist"),
			let configDictionary = NSDictionary(contentsOfFile: path),
			
			let token = configDictionary["Token"] as? String,
			let endpointString = configDictionary["Endpoint"] as? String,
			let endpointURL = URL(string: endpointString)
		else {
				fatalError("An error occurred while reading \(Constants.tmdbPlistName).plist")
		}
		
		return (token, endpointURL)
	}
	
}
