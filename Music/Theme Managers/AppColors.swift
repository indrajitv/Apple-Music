//
//  AppColors.swift
///   Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// App color contains all color information which are being used in entire app. It has theme property which will contain the current theme being used in app.
class AppColor {
    
    /// This will return the selected theme for the app. We can have multiple theme in future e.g dark mode support.
    static var theme:ColorProtocol{
        get{
            return RegularColorTheme() // Change this return value according to need. e.g. DarkColorTheme()
        }
    }
}

/// Color theme protocol which needs to be implemted by the theme of the app. All theme will inherite this protocal.
protocol ColorProtocol {
    
    var color1:UIColor{get}
    var color2:UIColor{get}
    var color3:UIColor{get}
}

/// Theme type 1 or regular theme.
fileprivate class RegularColorTheme:ColorProtocol{
    
    /// Light theme color.
    var color1: UIColor{
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    var color2: UIColor{
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var color3: UIColor{
        return AppColor.theme.color1.withAlphaComponent(0.5)
    }
    
}

/// Theme type 2.
fileprivate class DarkColorTheme:ColorProtocol{
    
    /// Light theme color.
    var color1: UIColor{
        return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    var color2: UIColor{
        return #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    }
    
    var color3: UIColor{
        return AppColor.theme.color1.withAlphaComponent(0.5)
    }
}
