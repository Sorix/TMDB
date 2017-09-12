//
//  APIRequests.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation
import tmdbAPI

// MARK: Possible requests

struct APIRequest {
	
	static var inTheatres: DiscoverRequest {
		let request = DiscoverRequest()
		request.parameters["sort_by"] = "popularity.desc"
		request.parameters["primary_release_date.gte"] = monthAgo
		request.parameters["primary_release_date.lte"] = dateFormatter.string(from: Date())
		return request
	}
	
	static var popular: DiscoverRequest {
		let request = DiscoverRequest()
		request.parameters["sort_by"] = "popularity.desc"
		return request
	}
	
	static var highestRated: DiscoverRequest {
		let request = DiscoverRequest()
		request.parameters["sort_by"] = "vote_average.desc"
		request.parameters["vote_count.gte"] = "500"
		request.parameters["primary_release_year"] = String(currentYear)
		return request
	}
	
	// MARK: Dates
	
	private static var currentYear: Int {
		let date = Date()
		let calendar = Calendar.current
		
		let year = calendar.component(.year, from: date)
		return year
	}

	private static var monthAgo: String {
		let monthAgo = Calendar.current.date(byAdding: Calendar.Component.month, value: -1, to: Date()) ?? Date()
		
		return dateFormatter.string(from: monthAgo)
	}
	
	private static var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}

}
