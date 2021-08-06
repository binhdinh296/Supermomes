//
//  ApiLogger.swift

//
//  Created by Mintpot on 3/24/21.
//

import Foundation
import Moya

class ApiLogger {
  
  static let shared = ApiLogger()
  
  var isEnabled = false
  private let logger = DI.container.resolve(ConsoleLoggerService.self)!
  
  init() {
    #if DEBUG
    isEnabled = true
    #endif
  }
  
  func log(_ message: Any, endpoint: ApiEndpoint) {
    if !isEnabled || !endpoint.isLogEnabled { return }
    logger.debug(message)
  }
  
  func logRequest(_ endpoint: ApiEndpoint) {
    if !isEnabled || !endpoint.isLogEnabled { return }
    logger.debug("request: \(MoyaProvider.defaultEndpointMapping(for: endpoint).url)\nmethod: \(endpoint.method)")
    logger.info("parameters: \(endpoint.parameters)")
  }
  
  func logResponseObject(_ object: Codable, endpoint: ApiEndpoint) {
    if !isEnabled || !endpoint.isLogEnabled { return }
    logger.debug("api response:")
  }
  
  func logServerError(_ error: ServerError, endpoint: ApiEndpoint) {
    if !isEnabled || !endpoint.isLogEnabled { return }
    logger.error("-------Server error-------")
  }
  
  func logParseError(_ error: Error, endpoint: ApiEndpoint, data: Data) {
    if !isEnabled || !endpoint.isLogEnabled { return }
    logger.error("-----Parse error-----")
    logger.warning("\(error)")
  }
  
  func logRequestFailedError(_ error: Error, endpoint: ApiEndpoint) {
    if !isEnabled || !endpoint.isLogEnabled { return }
    logger.error("request failed with error: \(error)")
  }
}
