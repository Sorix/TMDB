//
//  ActivityIndicator.swift
//  TMDB
//
//  Created by Vasily Ulianov on 14/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

class ActivityIndicator {
	static var activities = 0
	
	/// Start activity
	///
	/// - Parameter activities: if you're starting more than one activity in time, you may specify number of activities here
	static func start(activities: Int = 1) {
		self.activities += activities
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = true
		}
	}
	
	/// Stop activity
	static func stop() {
		activities -= 1
		if activities <= 0 {
			DispatchQueue.main.async {
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
			}
		}
		
		// We will protect ourselfes from possible errors when we called `.stop()` multiple times without starting events
		if activities < 0 {
			activities = 0
			assertionFailure("Called .stop() without starting activity, error in your code")
		}
	}
}
