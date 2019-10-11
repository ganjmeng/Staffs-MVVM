//
//  StaffModel.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation
struct Staff: Codable {
    
    let id: Int
    let name: String
    let title: String
    let age: Int
    let hobby: String?
    let avatar: String?
    var rank :String? {
        get {
            let title = self.title
            if (title == TitleEnum.associate.rawValue || title == TitleEnum.seniorAssociate.rawValue) {
                return RankEnum.slave.rawValue
            } else if (title == TitleEnum.avp.rawValue || title == TitleEnum.vp.rawValue) {
                return RankEnum.boss.rawValue
            } else {
                return RankEnum.na.rawValue
            }
        }
    }
}

typealias Staffs = [Staff]

enum TitleEnum: String {
    case vp = "VP"
    case associate = "Associate"
    case seniorAssociate = "Senior Associate"
    case avp = "AVP"
}

enum RankEnum: String {
    case na = "N/A"
    case slave = "Slave"
    case boss = "Boss"
}
