//
//  StaffSceneDIContainer.swift
//
//  Created by Jingmeng.Gan on 7/9/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//
import UIKit

final class StaffSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransfer
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeFetchStaffUseCase() -> FetchStaffUseCase {
        return DefaultFetchStaffUseCase(staffsRepository: makeStaffRepository())
    }
    
    
    // MARK: - Repositories
    func makeStaffRepository() -> StaffRepository {
        return DefaultStaffRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Staffs List
    func makeStaffListViewController() -> UIViewController {
        return StaffListViewController.create(with: makeStaffsListViewModel(), staffListViewControllersFactory: self)
    }
    
    func makeStaffsListViewModel() -> StaffListViewModel {
        return DefaultStaffListViewModel(fetchStaffUseCase: makeFetchStaffUseCase())
    }
    
    
    // MARK: - Staffs Details
    func makeStaffsDetailsViewController(staff:Staff) -> UIViewController {
        return StaffDetailViewController.create(with: makeStaffsDetailsViewModel(staff: staff))
     }
     
    func makeStaffsDetailsViewModel(staff:Staff) -> StaffsDetailsViewModel {
        return DefaultStaffsDetailsViewModel(staff: staff)
     }
    
}

extension StaffSceneDIContainer:StaffListViewControllersFactory {}
