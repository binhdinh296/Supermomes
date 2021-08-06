//
//  ApiPlugins.swift

//
//  Created by Mintpot_Q on 11/6/20.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    
    return request
  }
}

protocol TimeoutableTargetType: TargetType {
  var timeout: TimeInterval { get }
}

struct TimeoutPlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    guard let target = target as? TimeoutableTargetType else {
      return request
    }
    var request = request
    request.timeoutInterval = target.timeout
    return request
  }
}

protocol ApiLoggable: TargetType {
  var isLogEnabled: Bool { get }
}
