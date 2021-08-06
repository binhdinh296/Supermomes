//
//  ApiRequest.swift

//
//  Created by Dinh Le on 3/24/21.
//

import Foundation
import Moya
import RxSwift

enum ApiResult<T> {
  case success(T)
  case error(Error)
}

protocol NetworkService {
  func request(_ endpoint: ApiEndpoint, progress: ((Double) -> Void)?, completion: ((Result<Moya.Response, MoyaError>) -> Void)?) -> Cancellable
  func request<T: Codable>(_ endpoint: ApiEndpoint, type: T.Type, progress: ((Double) -> Void)?, completion: ((ApiResult<T>) -> Void)?) -> Cancellable
  func request<T: Codable>(_ endpoint: ApiEndpoint, type: T.Type) -> Observable<ApiResult<T>>
}

class NetworkServiceImpl: NetworkService  {
  
  private let disposeBag = DisposeBag()
  
  lazy var provider: MoyaProvider<ApiEndpoint> = {
    let provider = MoyaProvider<ApiEndpoint>(
      plugins: [
        TimeoutPlugin()
      ]
    )
    return provider
  } ()
   
  func request(_ endpoint: ApiEndpoint, progress: ((Double) -> Void)? = nil, completion: ((Result<Moya.Response, MoyaError>) -> Void)? = nil) -> Cancellable {
    ApiLogger.shared.logRequest(endpoint)
    return provider.request(endpoint) { (progressResponse) in
      progress?(progressResponse.progress)
    } completion: { (result) in
      completion?(result)
    }
  }
  
  func request<T: Codable>(_ endpoint: ApiEndpoint, type: T.Type, progress: ((Double) -> Void)? = nil, completion: ((ApiResult<T>) -> Void)?) -> Cancellable {
    return request(endpoint, progress: progress) { (result) in
      let decoder = JSONDecoder()
      switch result {
      case .success(let response):
        ApiLogger.shared.log("done for request: \(response.request?.url?.absoluteString ?? "")", endpoint: endpoint)
        do {
          let filteredResponse = try response.filterSuccessfulStatusCodes()
          let object = try decoder.decode(T.self, from: filteredResponse.data)
            ApiLogger.shared.logResponseObject(object, endpoint: endpoint)
          
          completion?(ApiResult.success(object))
        } catch MoyaError.statusCode(_) {
          do {
            let serverError = try decoder.decode(ServerError.self, from: response.data)
            ApiLogger.shared.logServerError(serverError, endpoint: endpoint)
            completion?(ApiResult.error(ApiError.serverError(serverError)))
          } catch {
            ApiLogger.shared.logParseError(error, endpoint: endpoint, data: response.data)
            completion?(ApiResult.error(ApiError.parseFailed))
          }
        } catch {
            ApiLogger.shared.logParseError(error, endpoint: endpoint, data: response.data)
          completion?(ApiResult.error(ApiError.parseFailed))
        }
      case .failure(let error):
        ApiLogger.shared.logRequestFailedError(error, endpoint: endpoint)
        completion?(ApiResult.error(ApiError.moyaError(error)))
      }
    }
  }
  
  func request<T: Codable>(_ endpoint: ApiEndpoint, type: T.Type) -> Observable<ApiResult<T>> {
    return Observable.create { (observer) -> Disposable in
      let task = self.request(endpoint, type: type) { (result) in
        observer.onNext(result)
        observer.onCompleted()
      }
      return Disposables.create {
        task.cancel()
      }
    }
  }
}
