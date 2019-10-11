//
//  StaffDetailViewModel.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation

protocol StaffsDetailsViewModelInput {
    func viewDidLoad()
    func updateAvatarImage()

}

protocol StaffsDetailsViewModelOutput {
    var staff : Staff { get }
    var name: Observable<String> { get }
    var age: Observable<Int> { get }
    var hobby: Observable<String?> { get }
    var rank: Observable<String?> { get }
    var avatarImage: Observable<Data?> { get }

}

protocol StaffsDetailsViewModel: StaffsDetailsViewModelInput, StaffsDetailsViewModelOutput {}

final class DefaultStaffsDetailsViewModel: StaffsDetailsViewModel {
        
    var staff: Staff
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    // MARK: - OUTPUT
    let name: Observable<String> = Observable("")
    let age: Observable<Int> = Observable(0)
    let hobby: Observable<String?> = Observable("")
    let rank: Observable<String?> = Observable("")
    let avatarImage: Observable<Data?> = Observable(nil)

    private let avatar:String?

    init(staff: Staff) {
        self.staff = staff
        self.name.value = staff.name;
        self.age.value = staff.age;
        self.hobby.value = staff.hobby;
        self.rank.value = staff.rank;
        self.avatar = staff.avatar
        self.avatarImage.value = nil
    }
}

// MARK: - INPUT. View event methods
extension DefaultStaffsDetailsViewModel {
    func viewDidLoad() {}
    func updateAvatarImage() {
        guard let avatarPath = avatar else {return}
        
        self.downloadImage(from:URL(string:avatarPath)!, completion: { (data) in
            self.avatarImage.value = data
        })
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (Data) -> ()) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data)
        }
    }
}
