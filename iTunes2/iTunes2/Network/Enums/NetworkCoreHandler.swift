//
//  NetworkCoreHandler.swift
//  iTunes2
//
//  Created by Vinicius Albino on 19/08/23.
//

import Foundation

enum NetworkCoreHandler {
    case success
    
    case error(NetworkCoreErrorType)
    
    init(statusCode: Int) {
        switch NetworkCoreStatusCode(rawValue: statusCode) {
        case .noContent, .unknown:
            self = .error(.unknown)
        case .noConnection:
            self = .error(.noConnection)
        case .statusOK:
            self = .success
        case .badRequest:
            self = .error(.businessError)
        case .notFound:
            self = .error(.notFound)
        case .internalServerError:
            self = .error(.unknown)
        default:
            self = .error(.unknown)
        }
    }
}

enum NetworkCoreErrorType: Int, Swift.Error {
    case notFound
    case businessError
    case forbidden
    case serviceDown
    case cancelled
    case noConnection
    case unknown
    case noContent
    case `internal`
}

enum NetworkCoreStatusCode: Int {
    case noConnection = 0
    case unknown = -998
    case statusOK = 200
    case noContent = 204
    case badRequest = 400
    case notFound = 404
    case internalServerError = 500
    case created = 201
}
