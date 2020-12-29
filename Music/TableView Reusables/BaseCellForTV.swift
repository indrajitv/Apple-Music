//
//  File.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import UIKit

/// Base or parent cell for all table view cell. This reduces the rededent lines of code and makes all cells centralized.
class BaseCellForTV:UITableViewCell{
    
    /// Initializes a table cell with a style and a reuse identifier and returns it to the caller.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// To setup all UI of the cell.
    func setUpViews(){}
}
