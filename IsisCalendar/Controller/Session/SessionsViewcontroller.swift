//
//  SessionsViewcontroller.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 9/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

class SessionsViewcontroller: BaseViewController, UITableViewDelegate {
    
    /// override root view
    var Oview: SessionsView! { return self.view as! SessionsView }
    
    // MARK:- Properties
    
    private var items:NSArray!
    private var titleSession:NSString!
    private var dataSource :UITableViewDatasourceArray!
    private var cellEvent = EventCell.newAutoLayoutView()
    
    // MARK:- UIViewController

    override func loadView() {
        self.view = SessionsView()
    }
    
    ///
    /// Constructor
    ///
    /// :param: title: title session
    /// :param: items: items from event detail

    init(title:NSString, items:NSArray){
        super.init(nibName: nil, bundle: nil)
        self.titleSession = title;
        self.items = items;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
        initDatasource()
    }
    
    // MARK:- Private
    
    ///
    /// Init user interface
    ///
    
    private func initUI(){
        self.title = self.titleSession as? String
        self.edgesForExtendedLayout = .Bottom
        self.Oview.useRefreshControl = false
        self.Oview.tableView.delegate = self;
        self.Oview.tableView.rowHeight = UITableViewAutomaticDimension
        self.Oview.tableView.estimatedRowHeight = Constants.SIZE_MINIMUN_ROW
    
    }
    
    /// Get cell with flexible height
    ///
    /// :param: cell subclass from UITableViewCell
    /// :param: item model

    private func configureCell(cell:EventCell, item:EventFolderItem) -> EventCell{
        
        println(item.startDate)
        
        cell.title = item.title
        cell.subTitle = item.subTitle
        cell.date = item.startDate.toString()
        
        if item.images.count != 0{
            if let image = item.images[0] as? EventImage{
                if  image.links.count != 0{
                    if let link = image.links[0] as? EventImageLink{
                        cell.imageEvent = link.href
                    }
                }
            }
        }
        
        cell.setNeedsUpdateConstraints();
        cell.updateConstraintsIfNeeded();
        
        return cell
    }
    
    /// Initializing datasource for UITableView using items from event detail
    ///
    /// :param: cell subclass from UITableViewCell
    /// :param: item Core data object
    
    private func initDatasource(){
        self.dataSource = UITableViewDatasourceArray(tableView:self.Oview.tableView, cell:EventCell.self
            , createBlock: { (cell, item) -> UITableViewCell in
                let cellm:EventCell = cell as! EventCell
                let itemO:EventFolderItem = item as! EventFolderItem
                return self.configureCell(cellm, item: itemO)
        })
        
        self.dataSource.items = [self.items]
        self.Oview.tableView.reloadData()
        let indexRange = NSIndexSet(indexesInRange: NSMakeRange(0, [self.items].count))
        self.Oview.tableView.reloadSections(indexRange, withRowAnimation: .Bottom)
        self.Oview.showIndicator = false
    }
    
    // MARK:- UITableView Delegate
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let event = self.dataSource?.items?.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! EventFolderItem
        var url:NSString!
        if event.links.count != 0{
            if let eventLink = event.links[0] as? EventLink{
                url = eventLink.href
                let detail:SessionDetailViewController = SessionDetailViewController(title: event.title, urlEvent: url)
                self.navigationController?.pushViewController(detail, animated: true)
            }
        }
        self.Oview.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let event = self.dataSource?.items?.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! EventFolderItem
        configureCell(self.cellEvent, item: event)
        self.cellEvent.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(self.Oview.tableView.frame), CGRectGetHeight(self.cellEvent.bounds))
        self.cellEvent.setNeedsLayout();
        self.cellEvent.layoutIfNeeded();
        return self.cellEvent.compressHeigth()
    }
}
