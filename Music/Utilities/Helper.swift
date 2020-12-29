//
//  AppConstatns.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// App's static constant values
class Helper{
    
    /// Is current device iPad ?
    static var isPad:Bool{
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// This can be set according to the need.
    static let currentSelectedLanguage = "en" // Put "fr" for French.
  
}


/// To show general alert.
class AlertView {
    
    /// Shows alert.
   static func show(withTitle title: String?, withMessage message:String?) {
       
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "alert_view.button.hide".localise, style: .default, handler: { action in
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        })
        
    }
}
