//
//  Router.swift
//  NewDemo
//
//  Created by Mintpot on 3/16/21.
//

import Foundation
import UIKit

protocol AppRouterService {
    var navigation: UINavigationController? { get set }
    func pushToOtherView(_ toVC: UIViewController)
    func changeViewToWindow(rootViewControllers: [UIViewController])
    func moveToHomeView()->HomeViewController
    func moveToUserDetail(id:Int32) -> UserDetailViewController
}

class AppRouterImp: AppRouterService {
    var navigation: UINavigationController?

    init(navigation: UINavigationController?) {
      self.navigation = navigation
    }
    
    func pushToOtherView(_ toVC: UIViewController) {
        if let topVC = UIApplication.topViewController() {
            topVC.navigationController?.pushViewController(toVC, animated: true)
        }
    }
    
    func changeViewToWindow(rootViewControllers: [UIViewController]) {
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true
        navigation.viewControllers = rootViewControllers
        AppDelegate.shared.window?.rootViewController = navigation
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    func moveToHomeView()->HomeViewController{
        let vc = HomeViewController.loadFromNib()
        return vc
    }
    
    func moveToUserDetail(id:Int32) -> UserDetailViewController{
        let vc = UserDetailViewController.loadFromNib()
        vc.awakeFromNib()
        vc.viewModel.idUser = id
        return vc
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
