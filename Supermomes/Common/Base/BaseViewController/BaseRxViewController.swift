//
//  BaseRxViewController.swift
//  Created by Dinh Le
//

import Foundation
import SVProgressHUD
import RxSwift

class BaseRxViewController<T: BaseViewModel>: BaseViewController {
    var viewModel: T!
    lazy var disposeBag : DisposeBag = {
            return DisposeBag()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            self.createViewModel()
            usingRxBinding()
            rxSubscribe()
        }else {
            usingRxBinding()
            rxSubscribe()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createViewModel()
    }
    
    func createViewModel() {
        viewModel = T()
    }
    
    /// Handle view model
    func usingRxBinding() {
        viewModel.hudActivity.asDriver().drive { (isShow) in
            isShow ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }.disposed(by: disposeBag)
    }
    
    internal func rxSubscribe() {
      styleHubLoading()
      viewModel.hudActivity.asDriver()
        .drive(onNext: { isLoading in
          isLoading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        })
        .disposed(by: disposeBag)
    }
    
    private func styleHubLoading(){
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor(red: 0.36, green: 0.89, blue: 0.96, alpha: 1.00))//Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.white)        //HUD Color
        SVProgressHUD.setBackgroundLayerColor(UIColor.clear)    //Background Color
    }
}


