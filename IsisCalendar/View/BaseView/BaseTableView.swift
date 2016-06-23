//
//  BaseTableView.swift
//  IsisCalendar
//
//  Created by Jorge Sanmartin on 15/09/15.
//  Copyright (c) 2015 isis. All rights reserved.
//


class BaseTableView: BaseView {
    
    // MARK: Public properties
    
    var titleRefresh:String{
        get{
            if self.refreshControl != nil && self.refreshControl.attributedTitle != nil{
                return self.refreshControl.attributedTitle!.string
            }else{
                return ""
            }
        }
        set{
            if self.refreshControl != nil{
                let titleAttribute = NSMutableAttributedString(string: newValue)
                var range = (newValue as NSString).rangeOfString(newValue)
                titleAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
                self.refreshControl.attributedTitle = titleAttribute
            }
        }
    }
    
    var useRefreshControl:Bool{
        get{
            return self.refreshControl != nil
        }
        set{
            if(newValue){
                addRefreshControl()
            }else{
                if self.refreshControl != nil{
                    self.refreshControl.removeFromSuperview()
                    self.refreshControl = nil
                }
            }
        }
    }
    
    var tableView: UITableView!
    var loadMoreData:onLoadMoreData!
    
    // MARK: Private properties
    
    private var refreshControl:UIRefreshControl!
    
    override func setupConstraints(){
        self.tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
    }
    
    override func changeConstraints(){
        
    }
    
    override func initialize() {
        createSubViews()
        addSubviews()
        addStyles()
    }
    
    func createSubViews(){
        self.tableView = UITableView.init(frame: CGRectZero,style:UITableViewStyle.Grouped)
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false);
    }
    
    func addSubviews(){
        self.addSubview(self.tableView)
    }
    
    func addStyles(){
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    
    func refreshList(){
        if self.loadMoreData != nil{
            self.loadMoreData()
        }
    }
    
    // MARK:- Private
    
    private func addRefreshControl(){
        self.refreshControl = UIRefreshControl.newAutoLayoutView()
        self.tableView.addSubview(self.refreshControl)
        self.refreshControl.backgroundColor = UIColor.lightGrayColor()
        self.refreshControl.tintColor = AppStyles.primaryColorApp()
        self.refreshControl.addTarget(self, action: Selector("refreshList"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl.beginRefreshing()
    }
    
    // MARK:- Public
    
    func dissmissRefreshControl(){
        if self.useRefreshControl{
            self.refreshControl.endRefreshing()
        }
    }

}
