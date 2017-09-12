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
	
	struct Identifiers {
		static let cell = "stackCell"
		static let header = "sectionHeader"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		configureTableView()
		fetchData()
	}
	
	private func configureTableView() {
		tableView.rowHeight = 200
		tableView.estimatedSectionHeaderHeight = 10
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		tableView.register(SectionHeaderFooterView.nib, forHeaderFooterViewReuseIdentifier: Identifiers.header)
	}
	
	fileprivate func add(movies: [Movie], to section: Int) {
		self.tableData[section].movies = movies
		DispatchQueue.main.async {
			self.tableView.reloadSections([section], with: .automatic)
		}
	}
	
	override var prefersStatusBarHidden: Bool { return true }

}

// MARK: - TableViewController delegates

extension MoviesTableViewController {
	
	// MARK: Numbers
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return tableData.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	// MARK: Section title
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifiers.header) as? SectionHeaderFooterView
		view?.sectionTitleLabel.text = tableData[section].title
		return view
	}
	
	// MARK: Cell
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.cell, for: indexPath) as! StackTableViewCell
		cell.add(movies: tableData[indexPath.section].movies)
		return cell
	}
	
}

// MARK: - Data fetching

// We can move that logic to presenter / other class, but in test project I simplified some things.
extension MoviesTableViewController {

	func fetchData() {
		let config = TMDBConfigurationReader.read()
		let api = API(endpoint: config.endpoint, apiKey: config.token)
		
		api.fetch(request: APIRequest.inTheatres) { self.add(movies: $0, to: 0) }
		api.fetch(request: APIRequest.popular) { self.add(movies: $0, to: 1) }
		api.fetch(request: APIRequest.highestRated) { self.add(movies: $0, to: 2) }
	}
	
}

