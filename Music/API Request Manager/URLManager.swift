//
//  URLManager.swift
///   Indrajit
//
//  Created by Indrajit Chavda on 18/12/20.
//

import Foundation

/// Manager the API URLs.
struct URLManager {
    
    static let getTopSongs = getBaseURL() + "topsongs/limit=25/xml"
    
}


/// URLManager methods.
extension URLManager{
    
    /// This method return the base server API end point. This end point will be fetched from the URLConfig.json file which is in main bundle/resource folder. This json file can be set by CI-CD Jenkin (If the build was sent by CICD Jenking server and not by xCode.)
    /// - Returns: It retuns the base end point for all APIs.
    static func getBaseURL() -> String{
        return getURLFromConfigFile(subKey: "production")
    }
    
    /// This method returns the final API url for any API call. This will contain the BaseURL + API Name.
    private static func getURLFromConfigFile(key:String = "endpoints",subKey:String)->String{
        
        if let filePath = Bundle.main.url(forResource: "URLConfig", withExtension: "json"),
           let dataOfPath = try? Data(contentsOf: filePath){
            
            if let json = try? JSONSerialization.jsonObject(with: dataOfPath, options: .mutableContainers) as? [String:Any],
               let infra = json["infrastructure"] as? [String:Any],
               let endpoints = infra[key] as? [String:Any]{
                
                if let urlString = endpoints[subKey] as? String{
                    return urlString
                }
            }
        }
        
        fatalError("There must be some issues in config file.")
   
    }
    
}
