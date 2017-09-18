//
//  StackTableViewCell.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

class StackTableViewCell: UITableViewCell {
	
	@IBOutlet weak var scollView: UIScrollView!
	@IBOutlet weak var stackView: UIStackView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		stackView.axis = .horizontal
	}
	
	func set(movies: [Movie]) {
		clearStack()
		
		for movie in movies {
			downloadAndAdd(movie: movie)
		}
	}
	
	private func downloadAndAdd(movie: Movie) {
		if let _ = movie.posterImage {
			// If image is already downloaded
			add(toStack: movie)
		} else {
			// If image is downloaded
			let downloadImageOperation = ImageDownloadOperation(from: movie.posterPath)
			downloadImageOperation.downloadCompletionBlock = { image, error in
				DispatchQueue.main.async {
					movie.posterImage = image
					self.add(toStack: movie)
				}
			}
			
			MoviesTableViewController.imageDownloadQueue.addOperation(downloadImageOperation)
		}
	}
	
	private func add(toStack movie: Movie) {
		let movieView = MovieView.instanceFromNib()
		movieView.display(movie: movie)
		stackView.addArrangedSubview(movieView)
	}
	
	private func clearStack() {
		for subview in stackView.arrangedSubviews {
			stackView.removeArrangedSubview(subview)
		}
	}
	
}
