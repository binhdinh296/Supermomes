//
//  Logger.swift
//  Supermomes
//
//  Created by Mintpot on 8/6/21.
//

import Foundation

class Logger {
  
  static let shared = Logger()
  
  private(set) var enable = false
  
  func start() {
    #if DEBUG
    enable = true
    #endif
  }
  
  var logService = DI.container.resolve(ConsoleLoggerService.self)!
  
  static func verbose(_ message: Any) {
    guard Logger.shared.enable else { return }
    Logger.shared.logService.verbose(message)
  }
  static func debug(_ message: Any) {
    guard Logger.shared.enable else { return }
    Logger.shared.logService.debug(message)
  }
  static func info(_ message: Any) {
    guard Logger.shared.enable else { return }
    Logger.shared.logService.info(message)
  }
  static func warning(_ message: Any) {
    guard Logger.shared.enable else { return }
    Logger.shared.logService.warning(message)
  }
  static func error(_ message: Any) {
    guard Logger.shared.enable else { return }
    Logger.shared.logService.error(message)
  }
  
}
