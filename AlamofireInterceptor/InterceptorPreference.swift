//
//  InterceptorPreference.swift
//  AlamofireInterceptor
//
//  Created by Nehal Elsawaf on 2/17/19.
//  Copyright © 2019 Yehia Elbehery. All rights reserved.
//

import UIKit

public let AlamofireInterceptorKey = "__AlamofireInterceptorKey__"
public let requestInterceptEnabledKey = "requestInterceptEnabledKey"
public let responseInterceptEnabledKey = "responseInterceptEnabledKey"

class InterceptorPreference: NSObject {
    static func requestInterceptSetTo(_ isEnabled: Bool){
        var interceptorStore: [String: Any?]
        if let store = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?] {
            interceptorStore = store
        }else{
            interceptorStore = [String: Any?]()
        }
        
        interceptorStore[requestInterceptEnabledKey] = isEnabled
        
        UserPreference.set(interceptorStore, key: AlamofireInterceptorKey)
    }
    static func responseInterceptSetTo(_ isEnabled: Bool){
        
        var interceptorStore: [String: Any?]
        if let store = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?] {
            interceptorStore = store
        }else{
            interceptorStore = [String: Any?]()
        }
        
        interceptorStore[responseInterceptEnabledKey] = isEnabled
        
        UserPreference.set(interceptorStore, key: AlamofireInterceptorKey)
    }
    
    static func requestInterceptIsEnabled() -> Bool {
        if let interceptorStore = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?], let requestInterceptEnabled = interceptorStore[requestInterceptEnabledKey] as? Bool{
            return requestInterceptEnabled
        }else{
            return false
        }
    }
    static func responseInterceptIsEnabled() -> Bool {
        if let interceptorStore = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?], let responseInterceptEnabled = interceptorStore[responseInterceptEnabledKey] as? Bool{
            return responseInterceptEnabled
        }else{
            return false
        }
    }
    
    
    static func getLastRequestUrl() -> String{
        if let interceptorStore = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?], let url = interceptorStore["url"] as? String{
            return url
        }else{
            return ""
        }
        
    }
    static func getLastRequestParams() -> String{
        if let interceptorStore = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?], let params = interceptorStore["params"] as? String{
            return params
        }else{
            return ""
        }
    }
    static func getLastRequestResponse() -> String{
        if let interceptorStore = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?], let response = interceptorStore["response"] as? String{
            return response
        }else{
            return ""
        }
    }
    static func setUrl(_ url: String){
        
        var interceptorStore: [String: Any?]
        if let store = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?] {
            interceptorStore = store
        }else{
            interceptorStore = [String: Any?]()
        }
        
        interceptorStore["url"] = url
        
        UserPreference.set(interceptorStore, key: AlamofireInterceptorKey)
    }
    static func setParams(_ params: String){
        
        var interceptorStore: [String: Any?]
        if let store = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?] {
            interceptorStore = store
        }else{
            interceptorStore = [String: Any?]()
        }
        
        interceptorStore["params"] = params
        
        UserPreference.set(interceptorStore, key: AlamofireInterceptorKey)
    }
    static func setResponse(_ response: String){
        
        var interceptorStore: [String: Any?]
        if let store = UserPreference.get(AlamofireInterceptorKey) as? [String: Any?] {
            interceptorStore = store
        }else{
            interceptorStore = [String: Any?]()
        }
        
        interceptorStore["response"] = response
        
        UserPreference.set(interceptorStore, key: AlamofireInterceptorKey)
    }
}
