//
//  SessionDetailViewController.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 10/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

class SessionDetailViewController: BaseViewController {
    
    /// override root view
    var Oview: SessionDetailView! { return self.view as! SessionDetailView }
    
    // MARK:- Properties
    
    private var titleSession :String!
    private var urlSession :String!
    
    // MARK:- UIViewController
    
    override func loadView() {
        self.view = SessionDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = self.titleSession
        self.edgesForExtendedLayout = .Bottom
        getSessionDetail()
    }
    
    init(title:NSString, urlEvent:NSString){
        super.init(nibName: nil, bundle: nil)
        self.titleSession = title as String
        self.urlSession = urlEvent as String
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Request detail session
    
    private func getSessionDetail(){
        self.Oview.showIndicator = true
        CalendarUseCases.getSessionDetail(self.urlSession, success: { (result) -> Void in
            self.Oview.showIndicator = false
            let session = result as! Session
            self.configureView(session)
        }) { (error) -> Void in
            print(error.description)
            self.Oview.showIndicator = false
            self.showNetworkAlert()
        }
    }
    
    ///
    /// Configure view with Session model
    ///
    /// :param: session: model with neccesary data
    
    private func configureView(session:Session){
        
        if session.images != nil{
            self.Oview.createCarrouselWithImages(session.images)
        }
        
        if  session.title != nil{
            self.Oview.title = session.title
        }
        
        if session.subTitle != nil{
            self.Oview.subtitle = session.subTitle
        }
        
        if session.content != nil{
            self.Oview.content = session.content
        }
        
        self.updateViewConstraints()
        self.Oview.showWithAnimation()
    }
}
