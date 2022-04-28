//
//  Assets+CoreDataProperties.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 29/04/22.
//
//

import Foundation
import CoreData


extension Assets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Assets> {
        return NSFetchRequest<Assets>(entityName: "Assets")
    }

    @NSManaged public var desc: String?
    @NSManaged public var file_extension: String?
    @NSManaged public var name: String?
    @NSManaged public var source: String?
    @NSManaged public var symbol: String?
    @NSManaged public var type: String?
    @NSManaged public var file_type: String?
    @NSManaged public var duration: Double
    @NSManaged public var folder: Folder?
    @NSManaged public var intoProject: NSSet?
    
    public var assetInProject: [AsseProj]?
    {
        get
        {
            return intoProject?.allObjects as? [AsseProj]
        }
    }

}

// MARK: Generated accessors for intoProject
extension Assets {

    @objc(addIntoProjectObject:)
    @NSManaged public func addToIntoProject(_ value: AsseProj)

    @objc(removeIntoProjectObject:)
    @NSManaged public func removeFromIntoProject(_ value: AsseProj)

    @objc(addIntoProject:)
    @NSManaged public func addToIntoProject(_ values: NSSet)

    @objc(removeIntoProject:)
    @NSManaged public func removeFromIntoProject(_ values: NSSet)

}

extension Assets : Identifiable {

}
