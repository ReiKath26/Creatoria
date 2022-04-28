//
//  AsseProj+CoreDataProperties.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 29/04/22.
//
//

import Foundation
import CoreData


extension AsseProj {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AsseProj> {
        return NSFetchRequest<AsseProj>(entityName: "AsseProj")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var isSet: Bool
    @NSManaged public var assets: Assets?
    @NSManaged public var project: Projects?

}

extension AsseProj : Identifiable {

}
