//
//  StaffRepositoryInterfaces.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation
protocol StaffRepository {
    @discardableResult
    func staffsList(completion: @escaping (Result<Staffs, Error>) -> Void) -> Cancellable?
}

final class DefaultStaffRepository {
    
    private let dataTransferService: DataTransfer
    
    init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultStaffRepository: StaffRepository {
    
    public func staffsList(completion: @escaping (Result<Staffs, Error>) -> Void) -> Cancellable? {
        
        let endpoint = APIEndpoints.staffs()
        return self.dataTransferService.request(with: endpoint) { (response: Result<Staffs, Error>) in
            switch response {
            case .success(let staffs):
                completion(.success(staffs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

