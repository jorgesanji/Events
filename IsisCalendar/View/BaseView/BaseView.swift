//
//  BaseView.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 7/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

typealias onLoadMoreData = () -> Void

class BaseView: UIView {
    
    static let KTagIndicator:NSInteger = 1000
    
    /// Show or hide activity indicator
    var showIndicator:Bool{
        get{
            return self.showIndicator
        }
        set{
            if newValue{
                addIndicator()
            }else{
                self.viewWithTag(BaseView.KTagIndicator)?.removeFromSuperview()
            }
        }
    }
    
    /// Indicates already is setted constraints
    private var didSetupConstraints = false
    
    override func updateConstraints(){
        super.updateConstraints()
        if !self.didSetupConstraints{
            setupConstraints()
            self.didSetupConstraints = true
        }else{
            changeConstraints()
        }
    }
    
    override static func requiresConstraintBasedLayout() -> Bool{
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(){
        fatalError("initialize has not been implemented")
    }
    
    func setupConstraints(){
        fatalError("setupConstraints has not been implemented")
    }
    
    func changeConstraints(){
        fatalError("changeConstraints has not been implemented")
    }
    
    private func commonInit(){
        self.didSetupConstraints = false;
        initialize()
        updateConstraints()
    }
    
    private func addIndicator(){
        if let indicatorView = self.viewWithTag(BaseView.KTagIndicator) as? UIActivityIndicatorView{
            indicatorView.hidden = false
            indicatorView.startAnimating()
        }else{
            let indicatorView = UIActivityIndicatorView(activityIndicatorStyle:.Gray)
            indicatorView.setTranslatesAutoresizingMaskIntoConstraints(false);
            self.addSubview(indicatorView)
            indicatorView.autoCenterInSuperview()
            indicatorView.color = UIColor.redColor()
            indicatorView.hidesWhenStopped = true
            indicatorView.tag = BaseView.KTagIndicator;
            indicatorView.startAnimating()
        }
    }
}
