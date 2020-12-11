//
//  LocalStudyList+CoreDataProperties.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//
//

import Foundation
import CoreData


extension LocalStudyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalStudyList> {
        return NSFetchRequest<LocalStudyList>(entityName: "LocalStudyList")
    }

    @NSManaged public var list: [TestStudy]?
    @NSManaged public var study: NSSet?

}

// MARK: Generated accessors for study
extension LocalStudyList {

    @objc(addStudyObject:)
    @NSManaged public func addToStudy(_ value: LocalStudy)

    @objc(removeStudyObject:)
    @NSManaged public func removeFromStudy(_ value: LocalStudy)

    @objc(addStudy:)
    @NSManaged public func addToStudy(_ values: NSSet)

    @objc(removeStudy:)
    @NSManaged public func removeFromStudy(_ values: NSSet)

}

extension LocalStudyList : Identifiable {

}
