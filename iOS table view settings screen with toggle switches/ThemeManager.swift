//
//  ThemeManager.swift
//  iOS table view settings screen with toggle switches
//
//  Created by Engy on 10/30/24.
//

import Foundation

protocol ThemeDelegate: AnyObject {
    func didChangeTheme(isDarkMode:Bool)

}
class ThemeManager {
    static let shared = ThemeManager()
    private init() {}
     weak var delegate: ThemeDelegate?
    var isDarkMode:Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isDarkMode")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
            delegate?.didChangeTheme(isDarkMode: newValue)

        }

    }

}
