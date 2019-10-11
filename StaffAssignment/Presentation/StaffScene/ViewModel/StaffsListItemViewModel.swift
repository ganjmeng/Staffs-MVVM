//
//  StaffsListItemViewModel.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation

protocol StaffsListItemViewModelInput {
    func viewDidLoad()
}

protocol StaffsListItemViewModelOutput {
    var id: Int { get }
    var name: String { get }
    var title: String { get }
    var age : Int { get }
    var hobby: String? { get }
    var avatar: String? { get }
    var staff : Staff { get }
    
}

protocol StaffsListItemViewModel: StaffsListItemViewModelInput, StaffsListItemViewModelOutput {}

final class DefaultStaffsListItemViewModel: StaffsListItemViewModel {
    var staff: Staff
    let id: Int
    let name: String
    let title: String
    let age: Int
    let hobby: String?
    let avatar: String?

    init(staff: Staff) {
        self.id = staff.id
        self.name = staff.name
        self.title = staff.title
        self.age = staff.age
        self.hobby = staff.hobby
        self.avatar = staff.avatar
        self.staff = staff
    }
}

// MARK: - INPUT. View event methods
extension DefaultStaffsListItemViewModel {
    func viewDidLoad() {}
}
