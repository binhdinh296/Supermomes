//
//  UserDetailViewController.swift
//  Supermomes
//
//  Created by Dinh Le on 8/6/21.
//

import UIKit

class UserDetailViewController: BaseRxViewController<UserDetailViewModel>  {
    @IBOutlet weak var tableView: UITableView!
    var header  = HeaderProfileView.shared
    private(set) lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .cyan
        control.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return control
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserDetail()
        setupUI()
    }
    
    private func setupUI() {
        tableView.refreshControl = refreshControl
    }
    
    override func rxSubscribe() {
        super.rxSubscribe()
        viewModel.user.asDriver()
            .drive(onNext: {[weak self] result in
                guard let self = self,let user = result else {return}
                self.header.user = user
               // self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    @objc private func reloadData() {
        viewModel.getUserDetail()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.header.setupUI()
        return self.header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 800
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
