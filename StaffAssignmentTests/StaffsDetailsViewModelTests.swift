//
//  StaffsDetailsViewModelTests.swift
//  StaffAssignmentTests
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation
import XCTest
import StaffAssignment

class StaffsDetailsViewModelTests: XCTestCase {
     static let mockViewModel = DefaultStaffsDetailsViewModel(staff: Staff(id: 5, name: "Bryan", title: "VP", age: 18, hobby: "aws", avatar: "https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?"))
    
    func test_updateAvatarImageWithWidthEventReceived_thenImageDownloaded() {
        // given
        let viewModel = StaffsDetailsViewModelTests.mockViewModel;
        // when
        viewModel.updateAvatarImage()
        sleep(2)
        // then
        XCTAssertTrue(viewModel.avatarImage.value != nil)
    }
    
    func test_rankWithVPTitle_thenRankShouldEqualBoss() {
        // given
        let viewModel = StaffsDetailsViewModelTests.mockViewModel;
        // when
        let rank = viewModel.rank.value
        // then
        XCTAssertTrue(rank == "Boss")
    }
    
    func test_rankWithAssociateTitle_thenRankShouldEqualSlave() {
        // given
        let viewModel = DefaultStaffsDetailsViewModel(staff: Staff(id: 5, name: "Bryan", title: "Associate", age: 18, hobby: "aws", avatar: "https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?"));
        
        // when
        let rank = viewModel.rank.value
        // then
        XCTAssertTrue(rank == "Slave")
    }
    
}


