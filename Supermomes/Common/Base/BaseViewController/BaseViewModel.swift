//
//  BaseViewModel.swift
//
//  Created by Mintpot
//

import Foundation
import RxSwift
import RxCocoa

public class BaseViewModel {
    internal let disposeBag = DisposeBag()
    let hudActivity = ActivityIndicator()

    required public init() {}
    
}
