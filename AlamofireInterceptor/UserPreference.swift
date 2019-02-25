//
//  UserPreference.swift
//
//  Created by Yehia Elbehery.
//

import UIKit

class UserPreference {
    
    static func get(_ key: String!) -> AnyObject? {
        let defaults: UserDefaults = UserDefaults.standard
        
        if defaults.value(forKey: key) == nil {
            return nil
        }else{
            return defaults.value(forKey: key) as AnyObject
        }
    }
    
    static func set(_ value: Any?, key: String!) {
        if value != nil  {
            let defaults: UserDefaults = UserDefaults.standard
            defaults.set(value as AnyObject, forKey: key)
            defaults.synchronize()
        }
    }
    
    static func remove(_ key: String!) {
        let defaults: UserDefaults = UserDefaults.standard
        
        if defaults.value(forKey: key) != nil {
            defaults.removeObject(forKey: key)
            defaults.synchronize()
        }
    }
}
