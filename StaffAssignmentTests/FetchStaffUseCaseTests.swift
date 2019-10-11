//
//  FetchStaffUseCaseTests.swift
//  StaffAssignmentTests
//
//  Created by Jingmeng.Gan on 11/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import Foundation
import XCTest
import StaffAssignment


class FetchStaffUseCaseTests: XCTestCase {
    
    
     static let staffs: Staffs = {
            let jsonString = """
     [{"id":1,"name":"Henry","title":"Associate","age":20,"hobby":"soccer, table tennis, guitar, foosball, billard, badminton, games, coding, algorithm, drinking, hangout","avatar":"https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?"},{"id":2,"name":"Peter","title":"AVP","age":21,"avatar":"https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?"},{"id":3,"name":"Ethan","title":"Senior Associate","age":22,"hobby":"aws","avatar":"https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?"},{"id":4,"name":"Kay","title":"Senior Associate","age":24,"avatar":"https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?"},{"id":5,"name":"Bryan","title":"VP","age":25,"avatar":"https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?"}]
    """
            let jsonData = jsonString.data(using: .utf8)!
            let data = try! JSONDecoder().decode(Staffs.self, from: jsonData)
            return data
        }()
    
    enum FetchStaffsRepositorySuccessTestError: Error {
           case failedFetching
       }
      
    class FetchStaffsRepositorySuccessMock: StaffRepository {
        func staffsList(completion: @escaping (Result<Staffs, Error>) -> Void) -> Cancellable? {
           completion(.success(staffs))
           return nil
       }
    }

    class FetchStaffsRepositoryFailureMock: StaffRepository {
        func staffsList(completion: @escaping (Result<Staffs, Error>) -> Void) -> Cancellable? {
            completion(.failure(FetchStaffsRepositorySuccessTestError.failedFetching))
           return nil
       }
    }
    
    func testFetchStaffUseCase_whenSuccessfullyFetchesData_thenSuccussAndResultMustBeTrue() {
        // given
        let expectation = self.expectation(description: "Successfully Fetches Data")
        expectation.expectedFulfillmentCount = 1
        
        let useCase = DefaultFetchStaffUseCase(staffsRepository: FetchStaffsRepositorySuccessMock())
        
        // then
        var expectResult : Staffs? = nil;
        _ = useCase.execute() { result in
            
            expectResult = try! result.get()
            expectation.fulfill()
        }
    
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue( (expectResult != nil) && expectResult!.count > 0)
    }
    
    func testFetchStaffUseCase_whenFailedFetchesData_thenStaffsShouldBeNil() {
        // given
        let expectation = self.expectation(description: "Successfully Fetches Data")
        expectation.expectedFulfillmentCount = 1
        
        let useCase = DefaultFetchStaffUseCase(staffsRepository: FetchStaffsRepositoryFailureMock())
        
        // then
        var expectResult : Staffs? = nil;
        _ = useCase.execute() { result in
            
            expectResult = try? result.get()
            expectation.fulfill()
        }
    
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(expectResult == nil)
    }
}
