//
//  UserDetailViewModel.swift
//  Supermomes
//
//  Created by Dinh Le on 8/6/21.
//

import Foundation
import RxCocoa

class UserDetailViewModel :BaseViewModel{
    private let service = DI.container.resolve(RequestApiRepository.self)
    var user = BehaviorRelay<UserResponse?>(value:nil)
    var idUser:Int32!
    
    func getUserDetail(){
        service?.getUserDetail(id: idUser)
            .trackActivity(hudActivity)
            .subscribe(onNext: {[weak self] result in
                switch result {
                case .success(let objs):
                    self?.user.accept(objs)
                case .error(let error):
                    Logger.debug(error)
                }
            }).disposed(by: disposeBag)
    }
}
