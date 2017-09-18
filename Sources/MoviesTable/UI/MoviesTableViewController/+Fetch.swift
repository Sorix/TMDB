//
//  +Fetch.swift
//  TMDB
//
//  Created by Vasily Ulianov on 18/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

extension MoviesTableViewController: MoviesFetcherDelegate {
	func fetchData() {
		self.fetcher = MoviesFetcher(delegate: self)
		fetcher?.fetchData()
	}
	
	func updated(movies: [Movie], type: MoviesFetcher.MovieType) {
		let sectionNumber: Int
		
		switch type {
		case .inTheatres: sectionNumber = 0
		case .popular: sectionNumber = 1
		case .highestRated: sectionNumber = 2
		}
		
		tableData[sectionNumber].movies = movies
		DispatchQueue.main.async {
			self.tableView.reloadSections([sectionNumber], with: .fade)
		}
	}
}
