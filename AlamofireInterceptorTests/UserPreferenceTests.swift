//
//  UserPreferenceTests.swift
//
//  Created by Yehia Elbehery.
//

import XCTest
@testable import AlamofireInterceptor

class UserPreferenceTests: XCTestCase {
    
    func test_get() {
        
        XCTAssert(UserPreference.get("randomEmptyKey") == nil)
        
        UserPreference.set("1", key: "someKey")
        XCTAssert(UserPreference.get("someKey") as! String == "1")
    }
    
    func test_set() {
        
        UserPreference.set("1", key: "someKey")
        XCTAssert(UserPreference.get("someKey") as! String == "1")
    }
    
    func test_remove(){
        UserPreference.set("1", key: "someKey")
        XCTAssert(UserPreference.get("someKey") as! String == "1")
        
        UserPreference.remove("someKey")
        XCTAssert(UserPreference.get("someKey") == nil)
    }
    
}
