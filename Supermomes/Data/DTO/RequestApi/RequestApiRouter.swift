//
//  RequestApiRouter.swift
//  Supermomes
//
//  Created by Dinh Le on 8/6/21.
//

import Foundation
import RxSwift

class BaseRepository {
  let networkService = DI.container.resolve(NetworkService.self)!
}

protocol RequestApiRepository {
    func getUsers() -> Observable<ApiResult<[UserResponse]>>
    func getUserDetail(id:Int32) -> Observable<ApiResult<UserResponse>>
}

class RequestApiService: BaseRepository,RequestApiRepository {
    
    func getUsers() -> Observable<ApiResult<[UserResponse]>>{
        return networkService.request(.GetUser, type: [UserResponse].self)
    }
    
    func getUserDetail(id:Int32) -> Observable<ApiResult<UserResponse>>{
        return networkService.request(.UserDetail(id: id), type: UserResponse.self)
    }
}
