//
//  APIEndpoints.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation

struct APIEndpoints {
    
    static func staffs() -> DataEndpoint<Staffs> {
        
        return DataEndpoint(path: "bins/fm9rp")
    }
    
    static func avatar(path: String) -> DataEndpoint<Data> {

        return DataEndpoint(path: "2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg", isFullPath:false)
    }
}
