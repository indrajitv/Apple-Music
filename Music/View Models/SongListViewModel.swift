//
//  SongListViewModel.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import Foundation

/// View mode to manage SongsListViewController.
class SongListViewModel {

    /// Handles APIs.
    private let apiRequest = APIRequest()
    
    /// Table cell ID.
    let cellID = "cellId"
    
    /// Title to show on top song view.
    let navigationTitle = "song_list.navigation.title.top_songs".localise
    
    /// Top songs to be shown.
    var songs = [SongViewModel]()
    
    /// Songs view model which parses and manages data sources.
    private var songsViewModel:SongsViewModel? {
        didSet {
            self.songs = songsViewModel?.songs ?? []
        }
    }
    
    /// Calls API to ger to get top song list.
    func getTopSongs(completionHanlder: @escaping( _ result:Result<[SongViewModel],Error>) -> Void) {
        
        if let cachedSongs = CoreDBManager.getAllSongsFromDB(),
           !cachedSongs.isEmpty{
            
            self.songs = cachedSongs
            self.orderSongsByIds()
            completionHanlder(.success(cachedSongs))
            
        }else {
            guard let url = URL(string: URLManager.getTopSongs) else {
                fatalError("Something wrong with URL.")
            }
            
            self.apiRequest.request(url: url) {[weak self] ( result) in
                
                guard let self = self else { return }
                
                switch result {
                    case .success(let success):
                        
                        self.songsViewModel =  SongsViewModel(xmlData: success)
                        CoreDBManager.insert(topSongs: self.songs)
                        self.orderSongsByIds()
                        completionHanlder(.success(self.songs))
                        
                    case .failure(let error):
                        
                        completionHanlder(.failure(error))
                        print(error.localizedDescription)
                        
                    case .none:
                        completionHanlder(.failure(NSError(domain: "general.error.someting_wrong".localise, code: 100, userInfo: nil) as Error))
                }
                
                
            }
        }
        
        
    }
    
    /// Orders by IDs.
    func orderSongsByIds(){
        self.songs.sort(by: {$0.id ?? "" < $1.id ?? ""})
    }
}





