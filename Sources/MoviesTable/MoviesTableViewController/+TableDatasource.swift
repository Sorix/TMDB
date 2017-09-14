//
//  TableDatasource.swift
//  TMDB
//
//  Created by Vasily Ulianov on 14/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

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
		cell.set(movies: tableData[indexPath.section].movies)
		return cell
	}
	
}
