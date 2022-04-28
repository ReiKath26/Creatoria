//
//  Projects+CoreDataProperties.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 29/04/22.
//
//

import Foundation
import CoreData


extension Projects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Projects> {
        return NSFetchRequest<Projects>(entityName: "Projects")
    }

    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var symbol: String?
    @NSManaged public var assets: NSSet?
    
    public var assetArray : [AsseProj]?
    {
        get
        {
            return assets?.allObjects as? [AsseProj]
        }
    }

}

// MARK: Generated accessors for assets
extension Projects {

    @objc(addAssetsObject:)
    @NSManaged public func addToAssets(_ value: AsseProj)

    @objc(removeAssetsObject:)
    @NSManaged public func removeFromAssets(_ value: AsseProj)

    @objc(addAssets:)
    @NSManaged public func addToAssets(_ values: NSSet)

    @objc(removeAssets:)
    @NSManaged public func removeFromAssets(_ values: NSSet)

}

extension Projects : Identifiable {

}
