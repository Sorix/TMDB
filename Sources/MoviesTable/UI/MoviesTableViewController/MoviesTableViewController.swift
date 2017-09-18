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
	
	var fetcher: MoviesFetcher?
	
	override func viewDidLoad() {
		super.viewDidLoad()

		configureTableView()
		fetchData()
	}
	
	override var prefersStatusBarHidden: Bool { return true }
	
	private func configureTableView() {
		tableView.rowHeight = 200
		tableView.estimatedSectionHeaderHeight = 10
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		tableView.register(SectionHeaderFooterView.nib, forHeaderFooterViewReuseIdentifier: Identifiers.header)
	}

	func add(movies: [Movie], to section: Int) {
		self.tableData[section].movies = movies
		DispatchQueue.main.async {
			self.tableView.reloadSections([section], with: .automatic)
		}
	}

}
