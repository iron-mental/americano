//
//  CoreUserInfo+CoreDataProperties.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/12.
//  Copyright © 2020 정재인. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreUserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreUserInfo> {
        return NSFetchRequest<CoreUserInfo>(entityName: "CoreUserInfo")
    }

    @NSManaged public var id: Int64
    @NSManaged public var nickname: String?
    @NSManaged public var email: String?
    @NSManaged public var image: String?
    @NSManaged public var introduce: String?
    @NSManaged public var address: String?
    @NSManaged public var careerTitle: String?
    @NSManaged public var careerContents: String?
    @NSManaged public var snsLinkedin: String?
    @NSManaged public var snsWeb: String?
    @NSManaged public var snsGithub: String?
    @NSManaged public var emailVerified: Bool
    @NSManaged public var createdAt: String?

}

extension CoreUserInfo : Identifiable {

}
