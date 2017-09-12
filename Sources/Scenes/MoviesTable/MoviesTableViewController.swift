//
//  ViewController.swift
//  TMDB
//
//  Created by Vasily Ulianov on 11/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
	
	static var imageDownloadQueue = OperationQueue() // static var for less complexity for test project
	
	var tableData = [
		MoviesTableSectionData(title: "New in Theatres"),
		MoviesTableSectionData(title: "Popular"),
		MoviesTableSectionData(title: "Highest Rated This Year")
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		MoviesTableViewController.imageDownloadQueue.maxConcurrentOperationCount = 1
		configureTableView()
		fetchData()
	}
	
	private func configureTableView() {
		tableView.rowHeight = 200
	}
	
	func fetchData() {
		let config = TMDBConfigurationReader.read()
		let api = API(endpoint: config.endpoint, apiKey: config.token)
		
		api.fetch(request: APIRequest.inTheatres) { self.add(movies: $0, to: 0) }
		api.fetch(request: APIRequest.popular) { self.add(movies: $0, to: 1) }
		api.fetch(request: APIRequest.highestRated) { self.add(movies: $0, to: 2) }
	}
	
	private func add(movies: [Movie], to section: Int) {
		self.tableData[section].movies = movies
		DispatchQueue.main.async {
			self.tableView.reloadSections([section], with: .automatic)
		}
	}

}

// MARK: - TableViewController delegates

extension MoviesTableViewController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return tableData.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return tableData[section].title
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "stackCell", for: indexPath) as! StackTableViewCell
		cell.add(movies: tableData[indexPath.section].movies)
		return cell
	}
	
}

