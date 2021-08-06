//
//  LoggerService.swift
//  Supermomes
//
//  Created by Dinh Le on 8/6/21.
//

import Foundation
import SwiftyBeaver

protocol ConsoleLoggerService {
    func verbose(_ message: Any)
    func debug(_ message: Any)
    func info(_ message: Any)
    func warning(_ message: Any)
    func error(_ message: Any)
}

class ConsoleLoggerServiceImp: ConsoleLoggerService {
  
  private let log = SwiftyBeaver.self
  
  init() {
    let console = ConsoleDestination()
    console.levelString.verbose = "💜 VERBOSE"
    console.levelString.debug = "💚 DEBUG"
    console.levelString.info = "💙 INFO"
    console.levelString.warning = "💛 WARNING"
    console.levelString.error = "❤️ ERROR"
    console.format = "$DHH:mm:ss$d $L $M"
    log.removeAllDestinations()
    log.addDestination(console)
  }
  
  // MARK: log
  func verbose(_ message: Any) {
    log.verbose(message)
  }
  
  func debug(_ message: Any) {
    log.debug(message)
  }
  
  func info(_ message: Any) {
    log.info(message)
  }
  
  func warning(_ message: Any) {
    log.warning(message)
  }
  
  func error(_ message: Any) {
    log.error(message)
  }
}

