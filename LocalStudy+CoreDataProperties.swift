//
//  LocalStudy+CoreDataProperties.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//
//

import Foundation
import CoreData


extension LocalStudy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalStudy> {
        return NSFetchRequest<LocalStudy>(entityName: "LocalStudy")
    }

    @NSManaged public var createAt: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var introduce: String?
    @NSManaged public var isMember: Bool
    @NSManaged public var leaderImage: String?
    @NSManaged public var members: Int64
    @NSManaged public var sigungu: String?
    @NSManaged public var title: String?

}

extension LocalStudy : Identifiable {

}
