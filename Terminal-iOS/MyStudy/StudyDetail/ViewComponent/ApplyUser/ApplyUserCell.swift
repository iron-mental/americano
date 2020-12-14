//
//  ApplyUserCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import Kingfisher

class ApplyUserCell: ApplyListCell {
    static let applyUserCellID = "applyUserCell"
    
    func setData(userList: ApplyUser) {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        if let imageURL = userList.image {
            self.mainImage.kf.setImage(with: URL(string: imageURL), options: [.requestModifier(imageDownloadRequest)])
        }
        
        self.title.text = userList.nickname
        self.contents.text = userList.message
    }
}
