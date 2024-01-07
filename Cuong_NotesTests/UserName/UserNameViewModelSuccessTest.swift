//
//  UserNameViewModelSuccessTest.swift
//  Cuong_NotesTests
//
//  Created by Macbook on 07/01/2024.
//

import XCTest
import Combine
@testable import Cuong_Notes

final class UserNameViewModelSuccessTest: XCTestCase {

    private var sut: UserNameViewModel!
    private var mockRepository: MockSuccessUserRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSuccessUserRepository()
        sut = UserNameViewModel(userRepository: mockRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockRepository = nil
    }
    
    func delay(_ closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: closure)
    }
    
    func testFetchCurrentUser() throws {
        let exp = XCTestExpectation(description: #function)
        sut.onAppear()
        XCTAssertTrue(mockRepository.invokedGetUserInfo, "The view model should fetch user information")
        delay {
            XCTAssertTrue(self.sut.shouldShowInputField, "The view model should show user name input for new user")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
    }
    
    func testRegisterNewUser() throws {
        let userName = "New name"
        sut.registerUser(with: userName)
        XCTAssertTrue(mockRepository.invokedRegisterNewUser, "The view model should call repository to register new user")
    }
}
