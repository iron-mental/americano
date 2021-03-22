//
//  CoreChatInfo+CoreDataProperties.swift
//  
//
//  Created by 정재인 on 2021/03/22.
//
//

import Foundation
import CoreData


extension CoreChatInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreChatInfo> {
        return NSFetchRequest<CoreChatInfo>(entityName: "CoreChatInfo")
    }

    @NSManaged public var chatList: [Chat]?
    @NSManaged public var studyID: Int64

}
