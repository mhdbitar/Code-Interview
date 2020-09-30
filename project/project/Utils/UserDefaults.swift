//
//  UserDefaults.swift
//  project
//
//  Created by Mohammad Bitar on 9/25/20.
//

import Foundation

class UserDefaults: NSObject {
    
    class func setValue (key: String, value: String) {
        let defaults = Foundation.UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    class func getValue (key: String) -> String {
        let defaults = Foundation.UserDefaults.standard
        if defaults.string(forKey: key) == nil {
            return ""
        } else {
            let value = defaults.string(forKey: key)!
            return value
        }
    }
    
    class func getValueInt(key: String) -> Int {
        let defaults = Foundation.UserDefaults.standard
        return defaults.integer(forKey: key)
    }
    
    class func isUserLoggedIn() -> Bool {
        
        if getValue(key: GlobalVariables.Parameters.IsLoggedIn.rawValue) == "1" {
            return true
        } else {
            return false
        }
    }
    
    class func logout () {
        let defaults = Foundation.UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { (key) in
            defaults.removeObject(forKey: key)
        }
    }

}
