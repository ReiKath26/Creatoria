//
//  Folder+CoreDataProperties.swift
//  Creatoria
//
//  Created by Kathleen Febiola Susanto on 29/04/22.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var directory: String?
    @NSManaged public var asset: NSSet?
    
    public var assetArray : [Assets]?
    {
        get
        {
            
            return asset?.allObjects as? [Assets]
        }
    }
    

}

// MARK: Generated accessors for asset
extension Folder {

    @objc(addAssetObject:)
    @NSManaged public func addToAsset(_ value: Assets)

    @objc(removeAssetObject:)
    @NSManaged public func removeFromAsset(_ value: Assets)

    @objc(addAsset:)
    @NSManaged public func addToAsset(_ values: NSSet)

    @objc(removeAsset:)
    @NSManaged public func removeFromAsset(_ values: NSSet)

}

extension Folder : Identifiable {

}
