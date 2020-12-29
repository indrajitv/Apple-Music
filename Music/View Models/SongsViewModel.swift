//
//  File.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import Foundation

/// We are not taking struct as we want to pass this class as a reference in parsing proccess.
class SongsViewModel:NSObject {
    
    private var xmlParse:XMLParser?
    
    var currentElement:String?
    
    var song:SongViewModel?
    
    var songs = [SongViewModel]()
    
    init(xmlData data:Data) {
        super.init()
        xmlParse = XMLParser(data: data)
        xmlParse?.delegate = self
        xmlParse?.parse()
    }
}




