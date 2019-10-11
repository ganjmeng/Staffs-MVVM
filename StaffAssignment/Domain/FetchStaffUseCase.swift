//
//  FetchStaffUseCase.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation

protocol FetchStaffUseCase {
    func execute(completion: @escaping (Result<Staffs, Error>) -> Void) -> Cancellable?
}

final class DefaultFetchStaffUseCase: FetchStaffUseCase {

    private let staffsRepository: StaffRepository
    
    init(staffsRepository: StaffRepository) {
        self.staffsRepository = staffsRepository
    }
    
    func execute(completion: @escaping (Result<Staffs, Error>) -> Void) -> Cancellable? {
        return staffsRepository.staffsList() { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                completion(result)
            }
        }
    }
}

//struct DefaultFetchStaffUseCaseRequestValue {
//    let query: String
//    let page: Int
//}
