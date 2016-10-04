//
//  ToDo+CoreDataProperties.swift
//  ToDoCourseraSwift3
//
//  Created by Hung Nguyen on 10/3/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo");
    }

    @NSManaged public var image: String?
    @NSManaged public var desciption: String?
    @NSManaged public var title: String?

}
