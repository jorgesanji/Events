//
//  ViewController.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 7/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import UIKit

class ListEventsViewController: BaseViewController, UITableViewDelegate {
    
    /// override root view
    var Oview: HomeView! { return self.view as! HomeView }
    
    // MARK:- Properties

    private var dataSource :UITableViewDatasourceArray!
    private var cellEvent = EventCell.newAutoLayoutView()
    private var pulltoRefresh:UIRefreshControl!
    
    // MARK:- UIViewController
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        self.view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
        initDatasource()
    }
    
    
    // MARK:- Private
    
    func showMap(sender:UIBarButtonItem){
        if self.dataSource.items == nil || self.dataSource.items?.count == 0{
            return
        }
        
        let itemSection = self.dataSource.items!.objectAtIndex(0) as! NSArray
        let mapViewController = EventsMapViewController(title: NSLocalizedString("map_events", comment: ""), items:itemSection)
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func reloadData(sender:UIBarButtonItem){
        getEvents();
    }
    
    /// Get cell with flexible height
    ///
    /// :param: cell subclass from UITableViewCell
    /// :param: item Core data object
    
    private func configureCell(cell:EventCell, item:CDEvent) -> EventCell{
        
        println(item.startDate)
        
        cell.title = item.title
        cell.subTitle = item.subTitle
        cell.date = item.startDate.toString()
        
        if item.images.count != 0{
            let images = item.images.allObjects
            if let image = images[0] as? CDEventImage{
                cell.imageEvent = image.link
            }
        }
        
        cell.setNeedsUpdateConstraints();
        cell.updateConstraintsIfNeeded();
        
        return cell
    }
    
    ///
    /// Initializing user interface
    ///
    
    private func initUI(){
        self.title = Constants.NAME_TITLE
        self.edgesForExtendedLayout = .Bottom
        self.Oview.loadMoreData = {
            self.getEvents()
        }
        self.Oview.useRefreshControl = true
        self.Oview.titleRefresh = NSLocalizedString("load_more" , comment: "")
        self.Oview.tableView.delegate = self;
        self.Oview.tableView.rowHeight = UITableViewAutomaticDimension
        self.Oview.tableView.estimatedRowHeight = Constants.SIZE_MINIMUN_ROW
        let mapButton = UIBarButtonItem(title: NSLocalizedString("map_events", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showMap:"))
        self.navigationItem.rightBarButtonItems = [mapButton]
        
        let reloadButton = UIBarButtonItem(title: NSLocalizedString("reload_data", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("reloadData:"))
        self.navigationItem.leftBarButtonItems = [reloadButton]
    }
    
    ///
    /// Initializing data source
    ///
    
    private func initDatasource(){
        self.dataSource = UITableViewDatasourceArray(tableView:self.Oview.tableView, cell:EventCell.self
            , createBlock: { (cell, item) -> UITableViewCell in
                let cellm:EventCell = cell as! EventCell
                let itemO:CDEvent = item as! CDEvent
                return self.configureCell(cellm, item: itemO)
        })
        
        getEvents()
    }
    
    // MARK:- Request Events
    
    private func getEvents(){
        self.Oview.showIndicator = true
        //
        CalendarUseCases.getEventList({ (result) -> Void in
            
            if let responseData:NSArray = result as? NSArray{
                let events: NSArray = [result]
                self.dataSource.items = events
                self.Oview.tableView.reloadData()
                let indexRange = NSIndexSet(indexesInRange: NSMakeRange(0, events.count))
                self.Oview.tableView.reloadSections(indexRange, withRowAnimation: .Bottom)
                self.Oview.showIndicator = false
                self.Oview.dissmissRefreshControl()
            }
            }, failure: { (error) -> Void in
                print(error.description)
                self.Oview.showIndicator = false
                self.Oview.dissmissRefreshControl()
                self.showNetworkAlert()
        });
    }
    
    // MARK:- UITableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let event = self.dataSource?.items?.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! CDEvent
        var url:NSString!
        if event.links.count != 0{
            let eventLinks = event.links.allObjects
            if let eventLink = eventLinks[0] as? CDEventLink{
                url = eventLink.link
                let detail:EventDetailViewController = EventDetailViewController(title: event.title, urlEvent: url)
                self.navigationController?.pushViewController(detail, animated: true)
            }
        }
        self.Oview.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let event = self.dataSource?.items?.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! CDEvent
        configureCell(self.cellEvent, item: event)
        self.cellEvent.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(self.Oview.tableView.frame), CGRectGetHeight(self.cellEvent.bounds))
        self.cellEvent.setNeedsLayout();
        self.cellEvent.layoutIfNeeded();
        return self.cellEvent.compressHeigth()
    }
    
}

