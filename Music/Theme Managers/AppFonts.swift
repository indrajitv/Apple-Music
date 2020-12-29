//
//  AppFonts.swift
///   Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// Application's fonts family manager.
class AppFont{
    
    /// Returns the fonts.
    /// - Parameters:
    ///   - font: Type/name of the font.
    ///   - size: Size of the fonts.
    /// - Returns: Returns the fonts according to the parameters.
    static func get(font: ThemeFont, size: FontSize)->UIFont {
        return UIFont.init(name: font.rawValue, size: adjustForDevice(size: size.rawValue))!
    }
    
    /// Adjusts the fonts according to the screen size.
    /// - Parameter size: Actual/General size of the font.
    /// - Returns: Calculated size for the screen from actual size.
    static func adjustForDevice(size:CGFloat)->CGFloat{
        return Helper.isPad ? size+(0.8 * size) : size
    }
    
}

/// Fonts sizes allowed in the app.
enum FontSize:CGFloat {
    case h0 = 70
    case h1 = 50
    case h2 = 32
    case h3 = 24
    case h4 = 17
    case h5 = 15
    case h6 = 13
    case h7 = 10
}

/// Fonts names allowed in the app.
enum ThemeFont:String {
    case light = "HelveticaNeue-Thin"
    case regular = "HelveticaNeue-Medium"
    case bold = "HelveticaNeue-Bold"
}


