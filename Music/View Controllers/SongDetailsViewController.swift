//
//  SongDetailsViewController.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import UIKit
import AVFoundation

/// Shoews details of the song. Plays song automatically
class SongDetailsViewController:ParentViewController{
    
    // MARK: Class properties
    
    /// Song plater.
    var player:AVAudioPlayer?
    
    /// Selected song from list view.
    var song:SongViewModel?
    
    /// UI: Imageview to show play image.
    let imageViewIcon:URLImageView={
        let imageView = URLImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    /// UI: Label to show song details.
    let labelNowPlaying:UILabel={
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK: Lifecycle methods
    
    /// Calls when view disappears.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.player?.stop()
        self.player = nil
    }
    
    
    // MARK: Class methods
    
    /// Sets view on screen and assigns autolayout constraints.
    override func setUpViews(){
        
        super.setUpViews()
        
        title = song?.title
        
        self.view.addSubviews(views: [imageViewIcon,labelNowPlaying])
        
        let imageSize:CGFloat = Helper.isPad ? 500 : self.view.frame.width
        
        imageViewIcon.setHeightAndWidth(height:imageSize, width:imageSize)
        imageViewIcon.setBottom(with: self.view.bottomAnchor,constant: 14)
        imageViewIcon.setCenterX()
        
        let padding:CGFloat = Helper.isPad ? 20 : 10
        labelNowPlaying.setAnchors(top: self.view.safeAreaLayoutGuide.topAnchor, bottom: imageViewIcon.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor,topConstant: padding,bottomConstant: -padding,leftConstant: padding,rightConstant: -padding)
        
        playAndShowSongDetails()
    }
   
    /// Plays song and show song details on label.
    func playAndShowSongDetails(){
     
        if let data = song?.cachedIcon {
            
            imageViewIcon.image = UIImage(data: data)
        }else if let url = song?.thumbURL{
            
            imageViewIcon.loadImage(from: url) {[weak self] (loadedImage) in
                self?.imageViewIcon.image = loadedImage
                self?.imageViewIcon.contentMode = .scaleAspectFill
                CoreDBManager.updateSongDetails(id: self?.song?.id ?? "", data: nil, status: self?.song?.downloadStatus ?? .none, cachedIcon: loadedImage?.pngData())
            }
        }
        
        self.labelNowPlaying.attributedText = song?.detailsLabel
   
        if let data = CoreDBManager.getSongPreviewData(id: self.song?.id ?? "-"){
            self.player = try? AVAudioPlayer(data: data)
            self.player?.delegate = self
            self.player?.play()
        }
        
    }
   
}

/// AVPlayer delegates.
extension SongDetailsViewController:AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.dismiss(animated: true, completion: nil)
    }
}
