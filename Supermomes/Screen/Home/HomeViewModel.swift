//
//  HomeViewModel.swift
//  Supermomes
//
//  Created by Mintpot on 8/6/21.
//

import Foundation
import RxCocoa
import CoreData

class HomeViewModel :BaseViewModel {
    private let service = DI.container.resolve(RequestApiRepository.self)
    var users = BehaviorRelay<[UserResponse]>(value: [])
    var isFirstLoad : Bool = true
    
    func getUsers(){
        service?.getUsers()
            .trackActivity(hudActivity)
            .subscribe(onNext: {[weak self] result in
                switch result {
                case .success(let objs):
                    self?.users.accept(objs)
                    self?.saveUsersToLocal()
                case .error(_):
                    self?.loadDataLocal()
                }
            }).disposed(by: disposeBag)
    }
    
    func saveUsersToLocal(){
        guard self.isFirstLoad,self.usersLocal().count == 0 else {return}
        isFirstLoad = false
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        for user in self.users.value {
            User(entity: entity!, insertInto: context).update(user: user)
            do{
                try context.save()
            }
            catch{
                print("context save error")
            }
        }
    }
    
    func loadDataLocal(){
        guard self.isFirstLoad else {return}
        var usersLocal : [UserResponse] = []
        for result in self.usersLocal(){
            let user = result as! User
            usersLocal.append(UserResponse(user: user))
        }
        self.users.accept(usersLocal)
    }
    
    private func getContext()->NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    private func usersLocal()->NSArray{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let results:NSArray = try self.getContext().fetch(request) as NSArray
            return results
        }
        catch{
            print("Fetch Failed")
        }
        return []
    }
}
