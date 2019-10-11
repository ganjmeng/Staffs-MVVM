//
//  StaffCell.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import UIKit

class StaffCell: UITableViewCell {
    static let reuseIdentifier = String(describing: StaffCell.self)
    private var viewModel: StaffsListItemViewModel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hobbyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with viewModel: StaffsListItemViewModel) {
        self.viewModel = viewModel
        self.nameLabel.text = viewModel.name
        self.hobbyLabel.text = viewModel.hobby
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
