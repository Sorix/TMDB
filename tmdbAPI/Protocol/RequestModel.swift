//
//  RequestModel.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import Foundation

public protocol RequestModel {
	var method: String { get }
	var parameters: [String: String] { get }
	
	associatedtype AnswerModel
	func format(json: [String: Any]) -> AnswerModel?
}
