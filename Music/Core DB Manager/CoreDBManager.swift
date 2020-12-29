//
//  CoreDBManager.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import Foundation
import CoreData

/// Core DB manager which contains basic properties and method.
class CoreDBManager{
    
    //MARK: Class propertis
    
    /// Core DB persistent container for entire DB.
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Music")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// Core DB persistent container context.
    class var context:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    //MARK: Class methods
    
    /// Saves the context.
    class func saveContext () {
        let context = CoreDBManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error{
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    /// Inserts new item.
    class func insert(topSongs songs:[SongViewModel]) {
        
        songs.forEach { (songToBeInsered) in
            let song = CoreDBSong.init(context: context)
            song.artist = songToBeInsered.artist
            song.category = songToBeInsered.category
            song.downloadStatus = Int16(songToBeInsered.downloadStatus.rawValue)
            song.id = songToBeInsered.id
            song.previewUrlString = songToBeInsered.previewUrlString
            song.thumbUrlString = songToBeInsered.thumbUrlString
            song.title = songToBeInsered.title
        }
        
        CoreDBManager.saveContext()
        
    }
    
    /// Updates the downloaded item.
    class func updateSongDetails(id:String,data:Data?,status:DownloadStatus,cachedIcon:Data? = nil) {
        let fetchRequest:NSFetchRequest<CoreDBSong> = CoreDBSong.fetchRequest()
        do{
            let results = try context.fetch(fetchRequest)
            
            let song = results.filter({id == $0.id}).first
            if let cachedIcon = cachedIcon{
                song?.cachedIcon = cachedIcon
            }else{
                song?.songData = data
                song?.downloadStatus = Int16(status.rawValue)
            }
            
            CoreDBManager.saveContext()
          
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    
    class func getAllSongsFromDB()->[SongViewModel]? {
        
        let fetchRequest:NSFetchRequest<CoreDBSong> = CoreDBSong.fetchRequest()
        do{
            let results = try context.fetch(fetchRequest)
            
            if !results.isEmpty{
                var songs = [SongViewModel]()
                results.forEach { (dbSong) in
                    let song = SongViewModel()
                    song.artist = dbSong.artist
                    song.category = dbSong.category
                    song.downloadStatus = DownloadStatus(rawValue: Int(dbSong.downloadStatus)) ?? .none
                    song.id = dbSong.id
                    song.previewUrlString = dbSong.previewUrlString
                    song.thumbUrlString = dbSong.thumbUrlString
                    song.cachedIcon = dbSong.cachedIcon
                    song.title = dbSong.title
                    songs.append(song)
                }
                return songs
            }
            
        }catch let error{
            print(error.localizedDescription)
        }
        
        return nil
        
    }
    
    /// Returns song preview data.
    class func getSongPreviewData(id:String)->Data?{
       
        let fetchRequest:NSFetchRequest<CoreDBSong> = CoreDBSong.fetchRequest()
        do{
           
            let results = try context.fetch(fetchRequest)
            return results.filter({id == $0.id}).first?.songData
            
        }catch let error{
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    
}
