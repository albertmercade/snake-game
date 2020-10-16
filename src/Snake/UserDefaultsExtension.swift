//
//  UserDefaultsExtension.swift
//  Snake
//
//  Created by Albert Mercadé on 21/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    func color(forKey key: String) -> UIColor? {
        guard let colorData = data(forKey: key) else {return nil}
        
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch let error {
            print("color error \(error.localizedDescription)")
            return nil
        }
    }
    
    func set(_ value: UIColor?, forKey key: String) {
        guard let color = value else { return }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
            set(data, forKey: key)
        } catch let error {
            print("error color key data not saved \(error.localizedDescription)")
        }
    }
}
