//
//  CoreDBSong+CoreDataClass.swift
//  
//
//  Created by Indrajit Chavda on 21/12/20.
//
//

import Foundation
import CoreData


public class CoreDBSong: NSManagedObject {
    
    @NSManaged public var title: String?
    @NSManaged public var artist: String?
    @NSManaged public var id: String?
    @NSManaged public var category: String?
    @NSManaged public var thumbUrlString: String?
    @NSManaged public var previewUrlString: String?
    @NSManaged public var downloadStatus: Int16
    @NSManaged public var songData,cachedIcon: Data?
    
}

