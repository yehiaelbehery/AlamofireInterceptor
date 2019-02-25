//
//  InterceptorPreferenceTests.swift
//  AlamofireInterceptorTests
//
//  Created by Nehal Elsawaf on 2/17/19.
//  Copyright © 2019 Yehia Elbehery. All rights reserved.
//

import XCTest
@testable import AlamofireInterceptor

class InterceptorPreferenceTests: XCTestCase {
    
    let originalUrl: String?, originalParams: String?, originalResponse: String?
    
    override func setUp() {
        if let interceptorStore = UserPreference.get(AlamofireInterceptorKey) {
            originalUrl = interceptorStore["url"]
            originalParams = interceptorStore["params"]
            originalResponse = interceptorStore["response"]
        }
        
    }
    
    func test_getLastRequest() {
        XCTAssert(InterceptorPreference.getLastRequestUrl() == nil)
        XCTAssert(InterceptorPreference.getLastRequestParams() == nil)
        XCTAssert(InterceptorPreference.getLastRequestResponse() == nil)
        
        let testUrl = "https://jsonbin.io/5c69aeab1198012fc89c7458"
        let testParams = "{\"params\":[]}"
        let testResponse = "{\"response\":[]}"
        var interceptorStore = [String: Any?]()
        interceptorStore["url"] = testUrl
        interceptorStore["params"] = testParams
        interceptorStore["response"] = testResponse
        
        UserPreference.set(interceptorStore, AlamofireInterceptorKey)
        
        XCTAssert(InterceptorPreference.getLastRequestUrl() == testUrl)
        XCTAssert(InterceptorPreference.getLastRequestParams() == testParams)
        XCTAssert(InterceptorPreference.getLastRequestResponse() == testResponse)
    }
    override func tearDown() {
        if let interceptorStore = UserPreference.get(AlamofireInterceptorKey) as? [Strin: Any?] {
            interceptorStore["url"] = originalUrl
            interceptorStore["params"] = originalParams
            interceptorStore["response"] = originalResponse
            UserPreference.set(interceptorStore, key:AlamofireInterceptorKey)
        }
    }

}
