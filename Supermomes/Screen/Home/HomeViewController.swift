//
//  HomeViewController.swift
//  Supermomes
//
//  Created by Dinh Le on 8/6/21.
//

import UIKit

class HomeViewController: BaseRxViewController<HomeViewModel> {
    @IBOutlet weak var tableView: UITableView!
    let cellId = "HomeViewCell"
    
    private(set) lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .black
        control.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUsers()
        self.setupUI()
    }
    
    private func setupUI() {
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func reloadData() {
        viewModel.getUsers()
        self.refreshControl.endRefreshing()
    }
    
    override func rxSubscribe() {
        super.rxSubscribe()
        viewModel.users.asDriver()
            .drive(onNext: {[weak self] users in
                guard let self = self,users.count > 0 else {return}
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! HomeViewCell
        cell.user = viewModel.users.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppRoute.pushToOtherView(AppRoute.moveToUserDetail(id: viewModel.users.value[indexPath.row].id))
    }
}
