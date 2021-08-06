//
//  AppContainer.swift
//  FitorProject
//
//  Created by Mintpot on 4/7/21.
//

import Foundation
import Swinject

typealias DI = AppContainer

enum AppContainer {
  
  static let container: Container = {
    let container = Container()
    container.registerServices()
    return container
  }()
}
