//
//  String+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/12.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func whitespaceCheck() -> Bool {
        return self.contains(" ")
    }
    
    func linkedInCheck() -> Bool {
        return self.contains("https://linkedin.com/") || self == ""
    }
    
    func webCheck() -> Bool {
        return self.contains("https://") || self == ""
    }
    
    func appstoreCheck() -> Bool {
        return self.contains("https://apps.apple.com/") || self == ""
    }
    
    func playstoreCheck() -> Bool {
        return self.contains("https://play.google.com/") || self == ""
    }
    
    func notionCheck() -> Bool {
        return self.contains("https://www.notion.so/") || self == ""
    }
    
    func evernoteCheck() -> Bool {
        return self.contains("https://www.evernote.com/") || self == ""
    }
}
