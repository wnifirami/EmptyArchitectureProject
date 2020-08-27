//
//  NetworkResponse.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
public enum APIError: Error {
    case parsingFailed
    case notConnectedToInternet
    case timedOut
    case emptyData
}

protocol NetworkResponse {}
