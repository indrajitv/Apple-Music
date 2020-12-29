//
//  LanguageManager.swift
///   Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// Manages language localizations.
extension String {
    
    /// Localizes the key into localized word.
    var localise:String{
        return localized()
    }
    
    /// Localizes the key into localized word.
    /// - Parameter bundle: App's bundle, Default is main.
    /// - Returns: If value found for key then value else key itself.
    func localized(bundle:Bundle? = nil) ->String {
        
        if let path = (bundle ?? Bundle.main).path(forResource: Helper.currentSelectedLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path){
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        
        return self // In case of failure, Sending back same key.
    }
    
}






