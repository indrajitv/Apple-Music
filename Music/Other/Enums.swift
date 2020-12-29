//
//  TestAPIStatus.swift
//  Encora
//
//  Created by Indrajit Chavda on 20/12/20.
//

import Foundation

/// Main XML tags to be parsed which have direct values.
enum SongXMLTages:String {
    case entry = "entry"
    case title = "title"
    case artist = "im:artist"
    case thumb = "im:image"
    case category = "category"
    case id = "id"
    
}

/// XML tags which has inline values.
enum SongXMLAttributes:String {
    case preview = "Preview"
    case title = "title"
    case href = "href"
    case id = "im:id"
    case label = "label"
}

/// Song download status.
enum DownloadStatus:Int {
    case none = 0
    case downloading = 1
    case downloaded = 2
    case failed = 3
    
    func getDisplayValue()->String{
        switch self {
            case .downloaded:
                return "general.title.downloaded".localise
            case .downloading:
            return "general.title.downloading".localise
            case .failed:
                return "general.title.failed".localise
            case .none:
                return ""
        }
    }
}


