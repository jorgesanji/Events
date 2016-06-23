//
//  DetailViewController.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//


class EventDetailViewController: BaseViewController {
    
    /// override root view
    var Oview: DetailView! { return self.view as! DetailView }
    
    // MARK:- Properties

    private var titleEvent :NSString!
    private var urlEvent :NSString!
    private var event:Event!
    
    // MARK:- UIViewController

    override func loadView() {
        self.view = DetailView()
    }
    
    ///
    /// Constructor
    ///
    /// :param: title string with event title
    /// :param: url evetn detail url
    ///
    
    init(title:NSString, urlEvent:NSString){
        super.init(nibName: nil, bundle: nil)
        self.titleEvent = title
        self.urlEvent = urlEvent
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI();
        getDetailEvent()
    }
    
    func showEvents(sender:UIBarButtonItem){
        let sessions = (self.event.folders[0] as! EventFolder).items as NSArray
        let title = (self.event.folders[0] as! EventFolder).name as String
        let sessionController:SessionsViewcontroller = SessionsViewcontroller(title:title
            , items:sessions)
        self.navigationController?.pushViewController(sessionController, animated: true)
    }
    
    // MARK:- Private
    
    ///
    /// Initializing user interface
    ///
    
    private func initUI(){
        self.edgesForExtendedLayout = .Bottom
        self.title = self.titleEvent as? String
        let eventsButton = UIBarButtonItem(title: NSLocalizedString("sessions_title", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showEvents:"))
        self.navigationItem.rightBarButtonItems = [eventsButton]
    }
    
    ///
    /// Request to Detail event
    ///
    
    private func getDetailEvent(){
        self.Oview.showIndicator = true
        CalendarUseCases.getEventDetail(self.urlEvent, success: { (result) -> Void in
            self.Oview.showIndicator = false
            self.event = result as! Event
            self.configureView()
            }) { (error) -> Void in
                print(error.description)
                self.Oview.showIndicator = false
                self.showNetworkAlert()
        }
    }
    
    ///
    /// Configure view with data event
    ///
    
    private func configureView(){
        self.Oview.createCarrouselWithImages(self.event.images)
        self.Oview.title = self.event.title
        self.Oview.subtitle = self.event.subTitle
        self.Oview.content = self.event.content
        self.updateViewConstraints()
        self.Oview.showWithAnimation()
    }
}
