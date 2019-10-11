//
//  StaffDetailViewController.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import UIKit

class StaffDetailViewController: UIViewController,StoryboardInstantiable, Alertable {
    
    private static let fadeDuration: CFTimeInterval = 0.4
    var viewModel: StaffsDetailsViewModel!
    final class func create(with viewModel: StaffsDetailsViewModel) -> StaffDetailViewController {
        let view = StaffDetailViewController.instantiateViewControllerWithIdentifier()
        view.viewModel = viewModel
        return view
    }
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var hobbyLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        // Do any additional setup after loading the view.
    }
    
    func bind(to viewModel: StaffsDetailsViewModel) {
        self.title = viewModel.staff.name;
        viewModel.name.observe(on: self) { [weak self] name in
            self?.title = name
        }
        viewModel.avatarImage.observe(on: self) { [weak self] image in
            DispatchQueue.main.async {
                self?.avatar.image = image.flatMap { UIImage(data: $0) }
            }
        }
        viewModel.age.observe(on: self) { [weak self] age in
            self?.ageLabel.text = String(age)
        }
        viewModel.hobby.observe(on: self) { [weak self] hobby in
            self?.hobbyLabel.text = hobby
        }
        viewModel.rank.observe(on: self) { [weak self] rank in
            self?.rankLabel.text = rank
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewModel.updateAvatarImage()
    }
}
