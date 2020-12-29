//
//  File.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import Foundation

/// Parasing delegates.
extension SongsViewModel:XMLParserDelegate{
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == SongXMLTages.entry.rawValue {
            song = SongViewModel()
        }
        currentElement = elementName
        
        if let title = attributeDict[SongXMLAttributes.title.rawValue],
           title == SongXMLAttributes.preview.rawValue { // This will get the download preview URL - Inline tag.
            
            song?.previewUrlString = attributeDict[SongXMLAttributes.href.rawValue]
        }
        
        if elementName == SongXMLTages.id.rawValue,
           let id = attributeDict[SongXMLAttributes.id.rawValue] { // This will get the download preview URL - Inline tag.
            
            song?.id = id
        }else if elementName == SongXMLTages.category.rawValue,
                 let label = attributeDict[SongXMLAttributes.label.rawValue] { // This will get the category.
            
            song?.category = label
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard let song = self.song else { return }
        
        if elementName == SongXMLTages.entry.rawValue{
            songs.append(song)
            self.song = SongViewModel()
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let value = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        guard let elementName = self.currentElement,
              let song = self.song,
              !value.isEmpty else { return }
        
        switch elementName {
            
            case SongXMLTages.artist.rawValue:
                song.artist = value
                
            case SongXMLTages.title.rawValue:
                song.title = value
                
            case SongXMLTages.thumb.rawValue:
                song.thumbUrlString = value
                
            default:
                break
        }
    }
}
