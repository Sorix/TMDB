//
//  API.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

public class API {
	
	let endpoint: URL
	let apiKey: String
	
	/// - Parameters:
	///   - endpoint: api endpoint url, example: `https://api.themoviedb.org/4/`
	public init(endpoint: URL, apiKey: String) {
		self.endpoint = endpoint
		self.apiKey = apiKey
	}
	
	/// Send request to TMDB API
	///
	/// - Parameters:
	///   - request: request conforming to `RequestModel` protocol
	///   - completion:
	///		- answer: parsed answer according to `RequestModel.AnswerModel`, maybe `nil` if any errors occured
	///		- error: error, `nil` if everything is okay
	public func send<T: RequestModel>(request: T, completion: @escaping (_ answer: T.AnswerModel?, _ error: Error?) -> Void) {
		guard let urlWithParameters = queryURL(method: request.method, parameters: request.parameters) else {
			completion(nil, ApiError.custom(description: "API request URL malformed"))
			return
		}
		
		NSLog("[API] Requesting: %@", urlWithParameters.absoluteString)
		
		// Send request
		let apiRequestTask = URLSession.shared.dataTask(with: urlWithParameters) {(data, response, error) in
			guard let data = data else {
				completion(nil, error)
				return
			}
			
			// Deserialize json
			do {
				if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
					let answerModel = request.format(json: json) {
					completion(answerModel, nil)
				} else {
					completion(nil, ApiError.invalidAnswer)
				}
			} catch let error {
				completion(nil, error)
			}
		}
		
		apiRequestTask.resume()
	}
	
	/// Make API query url for TMDB
	///
	/// - Parameters:
	///   - method: example: `/discover/movie/`
	///   - parameters: dictionary with parameters
	/// - Returns: created URL, e.g.: `https://api.themoviedb.org/3/discover/movie?api_key=123sort_by=popularity.desc`
	private func queryURL(method: String, parameters: [String: String]) -> URL? {
		var parametersWithToken = parameters
		parametersWithToken["api_key"] = apiKey
		
		let parametersString = parametersWithToken.flatMap { $0 + "=" + $1 }.joined(separator: "&")
		let finalURLString = endpoint.appendingPathComponent(method).absoluteString + "?" + parametersString
		
		return URL(string: finalURLString)
	}
	
}
