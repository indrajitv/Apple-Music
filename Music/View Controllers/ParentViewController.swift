//
//  ParentViewController.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// Parent for all UIViewController in the project.
class ParentViewController:UIViewController{
    
    //MARK: Lifecycle methods
    
    /// Apple-Default: Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        
    }
    
    //MARK: Class methods
    
    /// Sets views on screen and assigns autolayout constraints.
    func setUpViews(){
        self.view.backgroundColor = AppColor.theme.color2
    }
    
}
