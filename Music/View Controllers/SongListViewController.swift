//
//  SongListViewController.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// Main view controller which display and downloads top songs.
class SongListViewController:ParentViewController{
    
    //MARK: Class properties
    
    /// Contains all view's model and bussines logics.
    let songListViewModel = SongListViewModel()
    
    /// Table's datasource. Create new class in case of custom operation.
    lazy var tableDatasource = TableDatasource(cellID: songListViewModel.cellID, viewModels: songListViewModel.songs, designerHanlder: {  (cell, viewModel) in
        
        if let cell = cell as? TableViewCellSongDetails{
            cell.item = viewModel
        }
    })
    
    /// Table's delegates. Create new class with Parent this class in case of custom operation.
    lazy var tableDelegates = TableDelegates {[weak self] (selectedIndexPath) in
        
        if let selectedSong = self?.songListViewModel.songs[selectedIndexPath.section]{
            
            switch selectedSong.downloadStatus {
                case .downloaded:
                    self?.presentSongDetailsView(song: selectedSong)
                case .none,.failed:
                    selectedSong.startDownloadingSongAndStoreInDB()
                default:
                    break
            }
        }
        
    }
    
    /// UI: Table view which lists.
    lazy var tableView:UITableView={
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = tableDelegates
        tv.dataSource = tableDatasource
        tv.register(TableViewCellSongDetails.self, forCellReuseIdentifier: songListViewModel.cellID)
        tv.tableFooterView = UIView()// To remove unwanted seperators.
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.contentInset.bottom = 50
        return tv
    }()
    
    //MARK: Class methods
    
    /// Sets views on screen and assigns autolayout constraints.
    override func setUpViews(){
        super.setUpViews()
        
        title = songListViewModel.navigationTitle
        self.view.addSubview(tableView)
        tableView.setFullOnSuperView()
        loadTopSongsAndDisaply()
        
    }
    
    /// Requests server to server top songs.
    func loadTopSongsAndDisaply(){
        
        songListViewModel.getTopSongs {[weak self] (result) in
            
            switch result {
                case .success(let songs):
                    self?.tableDatasource.updateViewModels(data: self?.songListViewModel.songs ?? [])
                    self?.tableView.reloadData()
                    if songs.count == 0{
                        
                    }
                case .failure(let error):
                    AlertView.show(withTitle: nil, withMessage: error.localizedDescription)
                    break
            }
            
        }
    }
    
    /// Presents details view.
    func presentSongDetailsView(song:SongViewModel){
        
        let songDetailsViewController = SongDetailsViewController()
        songDetailsViewController.song = song
        self.present(UINavigationController(rootViewController: songDetailsViewController), animated: true, completion: nil)
   
    }
}

