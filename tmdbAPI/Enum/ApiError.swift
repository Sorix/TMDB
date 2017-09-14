//
//  AppError.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

enum ApiError: Error {
	case custom(description: String)
	case invalidAnswer
	
	var localizedDescription: String {
		switch self {
		case .custom(let description): return description
		case .invalidAnswer: return "Unexpected answer from API"
		}
	}
}
