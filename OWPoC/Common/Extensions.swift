//
//  Extensions.swift
//  OWPoC
//
//  Created by Paulo Silva on 04/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import Foundation
import UIKit

// String
extension String {
    
    public func replaceFirst(of pattern: String, with replacement: String) -> String {
        
        if let range = self.range(of: pattern) {
            return self.replacingCharacters(in: range, with: replacement)
        } else {
            return self
        }
        
    }
    
    public func replaceAll(of pattern: String, with replacement: String, options: NSRegularExpression.Options = []) -> String {
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(0..<self.utf16.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacement)
        } catch {
            DLog("replaceAll error: \(error)")
            return self
        }
        
    }
    
    func hashtags() -> [String] {
        
        if let regex = try? NSRegularExpression(pattern: "#[a-z0-9]+", options: .caseInsensitive) {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: "#", with: "").lowercased()
            }
        }
        
        return []
    }
    
    // print("\("string_value_to_localize".localizedString)")
    var localizedString: String {
        
        let fallbackLanguage: String = UserSettings.sharedInstance.fallbackLanguage
        let userLanguage: String = UserSettings.sharedInstance.language
        
        // System Default Language
        var bundle: Bundle? = Bundle.main
        
        if let userPath = Bundle.main.path(forResource: userLanguage, ofType: "lproj") {
            
            // User Default Language
            bundle = Bundle(path: userPath)
            
        } else {
            
            if let fallbackPath = Bundle.main.path(forResource: fallbackLanguage, ofType: "lproj") {
                
                // System Fallback Language
                bundle = Bundle(path: fallbackPath)
                
            }
            
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toDate (format: String) -> Date? {
        return DateFormatter(format: format).date(from: self)
    }
    
    func toDateString (inputFormat: String, outputFormat: String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
        }
        return nil
    }
    
}

// Date Formatter
extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

// Date
extension Date {
    
    func toString (format: String) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
}

// Button
extension UIButton {
    
    func imageNamed(_ named: String) {
        
        downloadImageNamed(named, fromUrl: "http://openweathermap.org/img/w/") { (image) in
            
            self.setImage(image, for: UIControlState.normal)
            
        }
        
    }
    
}

// Image
extension UIImageView {
    
    func imageNamed(_ named: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
    
        downloadImageNamed(named, fromUrl: "http://openweathermap.org/img/w/") { (image) in
            
            self.contentMode = mode
            self.image = image
            
        }
        
    }
    
}
