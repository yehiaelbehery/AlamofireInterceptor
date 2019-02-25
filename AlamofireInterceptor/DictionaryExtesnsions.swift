//
//  DictionaryExtensions.swift
//
//  Created by Yehia Elbehery.
//

import UIKit
extension Dictionary {
    
    func _convertedToJSONString() -> String {
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: self,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            return theJSONText
        }
        return "{}"
    }
}
