//
//  UITableViewDatasourceArray.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation
import UIKit

/// create block UITableView
typealias createCell = (cell:AnyObject, item:AnyObject) -> UITableViewCell

class UITableViewDatasourceArray : NSObject, UITableViewDataSource {
    var items:NSArray?
    private var cellClass:AnyClass?
    private var blockCreateCell:createCell?
    private var tableView:UITableView?
    
    ///
    /// Initializing UITableView datasource
    ///
    /// :param: tableview which is filled from this class
    /// :param: cell  sub class from UITableViewCell
    /// :param: createBlock block for create a row for tableview
    
    init(tableView:UITableView, cell:AnyClass, createBlock:createCell){
        self.blockCreateCell = createBlock
        self.cellClass = object_getClass(cell);
        self.tableView = tableView
        super.init()
        self.tableView!.dataSource = self;
        self.tableView!.registerClass(cell, forCellReuseIdentifier: toString(self.cellClass))
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        if self.items != nil{
            let itemSection = self.items!.objectAtIndex(section) as! NSArray
            return itemSection.count;
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell {
        let itemSection:NSArray = self.items!.objectAtIndex(indexPath.section) as! NSArray
        return blockCreateCell!(cell:tableView.dequeueReusableCellWithIdentifier(toString(self.cellClass))! ,item: itemSection.objectAtIndex(indexPath.row))
    }
}