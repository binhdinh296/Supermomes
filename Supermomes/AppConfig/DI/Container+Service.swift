//
//  Container+Service.swift
//  FitorProject
//
//  Created by Mintpot on 4/7/21.
//

import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    internal func registerServices() {
        autoregister(NetworkService.self, initializer: NetworkServiceImpl.init).inObjectScope(.container)
        autoregister(ConsoleLoggerService.self, initializer: ConsoleLoggerServiceImp.init).inObjectScope(.container)
        autoregister(AppRouterService.self, initializer: AppRouterImp.init).inObjectScope(.container)
        autoregister(RequestApiRepository.self, initializer: RequestApiService.init).inObjectScope(.container)
    }
}
