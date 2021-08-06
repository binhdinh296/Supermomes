//
//  ApiError.swift
//
//  Created by Mintpot on 11/6/20.
//

import Foundation
import Moya

struct ServerError: Codable {
  let code: String
  let message: String?
}

enum ApiError: Error {
  case parseFailed
  case moyaError(MoyaError)
  case serverError(ServerError)
}

extension ApiError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .moyaError(let error):
      return messageForMoyaError(error)
    case .serverError(let error):
      return messageForServerError(error)
    default:
      return "Text.Error.network"
    }
  }
}

enum ApiErrorCode: String {
    case Demo = "Demo"
}

extension ApiError {
  fileprivate func messageForMoyaError(_ error: MoyaError) -> String {
    switch error {
    default:
      return "Text.Error.network"
    }
  }

  fileprivate func messageForServerError(_ error: ServerError) -> String {
    guard let code = ApiErrorCode(rawValue: error.code) else { return "Text.Error.network" }
    switch code {
    default:
      return error.message ?? "Text.Error.network"
    }
  }

}
