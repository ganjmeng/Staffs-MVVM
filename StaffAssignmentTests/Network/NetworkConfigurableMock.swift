//
//  NetworkServiceMocks.swift
//  StaffAssignmentTests
//
//  Created by Jingmeng.Gan on 10/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//
import Foundation
import StaffAssignment


class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
