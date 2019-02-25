//
//  String.swift
//
//  Created by Yehia Elbehery.
//

import UIKit

extension String {
    
    func _convertedToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
