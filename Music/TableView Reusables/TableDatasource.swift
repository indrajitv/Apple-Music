//
//  TableDatasource.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import UIKit

/// This is general datasource of table view which can be reused in other classes.
class TableDatasource<Cell,ViewModel>:NSObject,UITableViewDataSource where Cell:UITableViewCell {
    
    //MARK: Class properties
    
    /// Cell id of the table.
    let cellID:String
    
    /// Datasource to be shown on cell.
    var viewModels:[ViewModel]
    
    /// Completion hanlder type.
    typealias CellDesignHanlder = (Cell?,ViewModel) -> ()
    
    /// Completion hanlder which help caller to design the cell.
    var designerHanlder:CellDesignHanlder?
    
    //MARK: Lifecycle methods
    
    ///  These details must be provided while creating object of this class.
    init(cellID:String,viewModels:[ViewModel],designerHanlder:CellDesignHanlder?) {
        self.cellID = cellID
        self.viewModels = viewModels
        self.designerHanlder = designerHanlder
        
    }
    
    /// Apple-Default: Number of raws in table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    /// Apple-Default: Sections in table.
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModels.count
    }
    
    /// Apple-Default: Dequeue cell and show datasource on cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? Cell
        designerHanlder?(cell,viewModels[indexPath.section])
        return cell ?? UITableViewCell()
        
    }
  
    /// Updates/refreshes new data.
    func updateViewModels(data:[ViewModel]){
        viewModels = data
    }
}
