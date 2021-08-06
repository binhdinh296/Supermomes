//
//  BaseViewModel.swift
//
//  Created by Dinh Le
//

import Foundation
import RxSwift
import RxCocoa

public class BaseViewModel {
    internal let disposeBag = DisposeBag()
    let hudActivity = ActivityIndicator()

    required public init() {}
    
}
