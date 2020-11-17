//
//  String+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/12.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

extension String {
    func replace(string:String, replacement:String) -> String {
           return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
       }

       func removeWhitespace() -> String {
           return self.replace(string: " ", replacement: "")
       }
}
