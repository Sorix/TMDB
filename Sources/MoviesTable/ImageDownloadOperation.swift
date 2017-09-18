//
//  ImageDownloadOperation.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

enum DownloadOperationError: Error {
	case notAnImage
}

class ImageDownloadOperation: Operation {
	
	let url: URL
	var downloadCompletionBlock: ((UIImage?, Error?) -> Void)?
	
	init(from url: URL) {
		self.url = url
	}
	
	override func main() {
		if self.isCancelled { return }
		
		do {
			let data = try Data(contentsOf: url)
			
			guard let image = UIImage(data: data) else {
				downloadCompletionBlock?(nil, DownloadOperationError.notAnImage)
				return
			}
			
			downloadCompletionBlock?(image, nil)
		} catch {
			downloadCompletionBlock?(nil, error)
		}
	}
	
}
