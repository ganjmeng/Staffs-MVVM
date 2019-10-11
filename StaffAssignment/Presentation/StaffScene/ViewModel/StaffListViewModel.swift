//
//  StaffListViewModel.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation

enum StaffListViewModelRoute {
    case initial
    case showStaffDetail(staff:Staff)
}

enum StaffListViewModelLoading {
    case none
    case show
    case hidden
}

protocol StaffListViewModelInput {
    func viewDidLoad()
    func didLoad()
    func didSelect(item: StaffsListItemViewModel)
}

protocol StaffListViewModelOutput {
    var route: Observable<StaffListViewModelRoute> { get }
    var items: Observable<[StaffsListItemViewModel]> { get }
    var loadingType: Observable<StaffListViewModelLoading> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
}

protocol StaffListViewModel: StaffListViewModelInput, StaffListViewModelOutput {}

final class DefaultStaffListViewModel: StaffListViewModel {

    private var staffsLoadTask: Cancellable? { willSet { staffsLoadTask?.cancel() } }
    private let fetchStaffUseCase: FetchStaffUseCase

    // MARK: - OUTPUT
      let route: Observable<StaffListViewModelRoute> = Observable(.initial)
      let items: Observable<[StaffsListItemViewModel]> = Observable([StaffsListItemViewModel]())
      let loadingType: Observable<StaffListViewModelLoading> = Observable(.none)
      let query: Observable<String> = Observable("")
      let error: Observable<String> = Observable("")
      var isEmpty: Bool { return items.value.isEmpty }
    
    @discardableResult
    init(fetchStaffUseCase: FetchStaffUseCase) {
        self.fetchStaffUseCase = fetchStaffUseCase
    }
    
    private func resetList() {
        items.value.removeAll()
    }
    
    private func refreshData(staffs: Staffs) {
      
        self.items.value = staffs.map {
            DefaultStaffsListItemViewModel(staff:$0)
        }
    }
    
    private func load(loadingType: StaffListViewModelLoading) {
        self.loadingType.value = loadingType
        
        staffsLoadTask = fetchStaffUseCase.execute() { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let staffs):
                strongSelf.refreshData(staffs: staffs)
            case .failure(let error):
                strongSelf.handle(error: error)
            }
            strongSelf.loadingType.value = .none
        }
    }
    private func handle(error: Error) {
        self.error.value = NSLocalizedString("Failed loading staffs", comment: "")
    }
    
    private func update() {
        resetList()
        load(loadingType: .show)
    }
}
extension DefaultStaffListViewModel {
    func viewDidLoad() {
        didLoad()
    }
    
    func didLoad() {
        update()
    }
    func didSelect(item: StaffsListItemViewModel) {
        route.value = .showStaffDetail(staff:item.staff)
    }
    
}
