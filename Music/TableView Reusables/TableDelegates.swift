//
//  TableDelegates.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import UIKit

class TableDelegates:NSObject,UITableViewDelegate{
    
    /// Completion hanlder type.
    typealias SelectionHanlder = (IndexPath) -> ()
    
    /// Completion hanlder which help caller to design the cell.
    var selectionHanlder:SelectionHanlder?
    
    init(selectionHanlder:SelectionHanlder?) {
        self.selectionHanlder = selectionHanlder
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Helper.isPad ? 25 : 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHanlder?(indexPath)
    }
    
}
