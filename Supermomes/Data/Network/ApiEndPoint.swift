//
//  NetworkService.swift

//
//  Created by Dinh Le on 3/24/21.
//

import Foundation
import Moya

enum ApiEndpoint {
    case GetUser
    case UserDetail(id:Int32)
}

extension ApiEndpoint: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var method: Moya.Method {
        switch self {
        case .GetUser,.UserDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var path: String {
        switch self {
        case .GetUser:
            return "/users"
        case .UserDetail(id: let id):
            return "/users/\(id)"
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }
    
    var encoding: ParameterEncoding {
        if method == .get {
            return URLEncoding.default
        }
        return JSONEncoding.default
    }
    
    var headers: [String : String]? {
        var allHeader: [String: String] = [:]
        switch self {
        default:
            allHeader["Content-Type"] = "application/json"
        }
        return allHeader
    }
    
}

extension ApiEndpoint: TimeoutableTargetType {

    var timeout: TimeInterval {
        switch self {
        default:
            return 30
        }
    }

}

extension ApiEndpoint: ApiLoggable {
  var isLogEnabled: Bool {
    switch self {
    default:
      return true
    }
  }
}

extension ApiEndpoint {
    var parameters: [String: Any] {
        return [:]
    }
    
    func multipartFormData(parameters: [String: Any]) -> [MultipartFormData] {
      var forms: [MultipartFormData] = []
      let emptyData = "".data(using: .utf8)!
      for (key, value) in parameters {
        forms.append(.init(provider: .data("\(value)".data(using: .utf8) ?? emptyData), name: key))
      }
      return forms
    }
}
