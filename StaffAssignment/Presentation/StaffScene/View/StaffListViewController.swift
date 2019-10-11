//
//  StaffListViewController.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 10/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import UIKit

class StaffListViewController: UIViewController, StoryboardInstantiable, Alertable, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!

    private(set) var viewModel: StaffListViewModel!
    private var staffListViewControllersFactory: StaffListViewControllersFactory!

    var items: [StaffsListItemViewModel]! {
        didSet { reload() }
    }
    
    
    final class func create(with viewModel: StaffListViewModel, staffListViewControllersFactory:StaffListViewControllersFactory) -> StaffListViewController {
        let vc = StaffListViewController.instantiateViewControllerWithIdentifier()
        vc.viewModel = viewModel
        vc.staffListViewControllersFactory = staffListViewControllersFactory;
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.topItem?.title = "Staff"
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        setupTableView()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func setupTableView() {
       
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView.init()
    }

    func bind(to viewModel: StaffListViewModel) {
        viewModel.route.observe(on: self) { [weak self] route in
            self?.handle(route)
        }
        viewModel.items.observe(on: self) { [weak self] items in
            self?.items = items;
        }

        viewModel.error.observe(on: self) { [weak self] error in
            self?.showError(error)
        }
        viewModel.loadingType.observe(on: self) { [weak self] _ in
            self?.updateViewsVisibility(model: viewModel)
        }
    }
    
    func reload() {
        tableView.reloadData()
    }

    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Error", message: error)
    }
    
    private func updateViewsVisibility(model: StaffListViewModel?) {
        guard let model = model else { return }
        
        if model.loadingType.value == .none{
            self.loadingView.stopAnimating()
        } else if model.loadingType.value == .show {
            self.loadingView.startAnimating()
        } else if model.isEmpty {
            self.loadingView.stopAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension StaffListViewController {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StaffCell.reuseIdentifier, for: indexPath) as? StaffCell else {
            fatalError("Cannot dequeue reusable cell \(StaffCell.self) with reuseIdentifier: \(StaffCell.reuseIdentifier)")
        }
        
        cell.fill(with: viewModel.items.value[indexPath.row])

        return cell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        viewModel.didSelect(item: items[indexPath.row])
    }
}


// MARK: - Handle Routing

extension StaffListViewController {
    func handle(_ route: StaffListViewModelRoute) {
        switch route {
        case .initial: break
            
        case .showStaffDetail(let staff):
            let vc = self.staffListViewControllersFactory.makeStaffsDetailsViewController(staff:staff)
            navigationController?.pushViewController(vc, animated: true)
            break
        }
    }
}

protocol StaffListViewControllersFactory {

    func makeStaffsDetailsViewController(staff:Staff) -> UIViewController
}
