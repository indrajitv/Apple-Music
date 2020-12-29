//
//  SongViewModel.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import UIKit

/// Song details.
class SongViewModel {
    
    /// Handles APIs.
    private let apiRequest = APIRequest()
    
    var title,artist,category,id:String?
    
    var thumbUrlString,previewUrlString:String?
    
    var cachedIcon:Data?
    
    var thumbURL:URL? {
        get{
            return URL(string: thumbUrlString ?? "")
        }
    }
    
    var previewURL:URL?{
        get{
            return URL(string: previewUrlString ?? "")
        }
    }
    
    var listDetails:NSAttributedString?{
        get{
            
            let attributedString = NSMutableAttributedString()
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.alignment = .left
            
            if let title = title{
                attributedString.append(.init(string:  title + "\n", attributes: [.font: AppFont.get(font: .regular, size: .h5),.foregroundColor:AppColor.theme.color1,.paragraphStyle:paragraphStyle]))
            }
            
            if let artist = artist{
                attributedString.append(.init(string: "song_list.in_cell.by".localise + ": "+artist, attributes: [.font: AppFont.get(font: .light, size: .h4),.foregroundColor:AppColor.theme.color1,.paragraphStyle:paragraphStyle]))
            }
            
            return attributedString
        }
    }
    
    var detailsLabel:NSAttributedString?{
        get{
            
            let attributedString = NSMutableAttributedString()
            
            attributedString.append(.init(string: "details_view.title.now_playing".localise + "\n\n", attributes: [.font: AppFont.get(font: .bold, size: .h2),.foregroundColor:AppColor.theme.color1]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.alignment = .center
            
            if let category = category{
                attributedString.append(.init(string: category + "\n", attributes: [.font: AppFont.get(font: .regular, size: .h4),.foregroundColor:AppColor.theme.color1,.paragraphStyle:paragraphStyle]))
            }
            
            if let artist = artist{
                attributedString.append(.init(string: "song_list.in_cell.by".localise + ": "+artist, attributes: [.font: AppFont.get(font: .light, size: .h5),.foregroundColor:AppColor.theme.color1,.paragraphStyle:paragraphStyle]))
            }
            
            return attributedString
        }
    }
   
    /// Current status of song.
    var downloadStatus:DownloadStatus = .none{
        didSet{
            self.downloadStatusChanged?(downloadStatus)
        }
    }
    
    /// Closer to objerver downloading status.
    var downloadStatusChanged:((DownloadStatus) -> Void)?
    
    // MARK: Class methods
    
    /// Downloads the song and stores in DB.
    func startDownloadingSongAndStoreInDB() {
        
        guard let id = self.id else {
            return
        }
        
        if let previewURL = previewURL{
            
            downloadStatus = .downloading
            apiRequest.request(url: previewURL) {[weak self] (result) in
                switch result{
                    case .failure(_):
                        self?.downloadStatus = .failed
                        CoreDBManager.updateSongDetails(id: id, data: nil, status: .failed)
                    case .success(let data):
                        self?.downloadStatus = .downloaded //
                        CoreDBManager.updateSongDetails(id: id, data: data, status: .downloaded)
                        
                    default:
                        break
                }
            }
        }else {
            downloadStatus = .failed
            CoreDBManager.updateSongDetails(id: id, data: nil, status: .failed)
        }
        
    }
    
}


