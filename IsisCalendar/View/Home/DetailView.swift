//
//  DetailView.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

class DetailView: BaseView, UIScrollViewDelegate {
    
    // MARK: Public properties
    
    var title:String{
        get{
            return self.titleLabel.text!
        }
        set{
            self.titleLabel.text = newValue
        }
    }
    
    var subtitle:String{
        get{
            return self.subtitleLabel.text!
        }
        set{
            self.subtitleLabel.text = newValue
        }
    }
    
    
    var content:String{
        get{
            return self.contentLabel.text!
        }
        set{
            self.contentLabel.text = newValue
        }
    }
    
    
    // MARK: Private properties
    
    var locationHiddenConstraints:NSArray!
    var contentView: UIView!
    var contentImageView: UIView!
    var contentScrollView: UIScrollView!
    var contentImagesScrollView: UIScrollView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var contentLabel: UILabel!
    var pageControl:UIPageControl!
    
    // MARK: Private
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width;
        self.subtitleLabel.preferredMaxLayoutWidth =  self.subtitleLabel.frame.size.width;
        self.contentLabel.preferredMaxLayoutWidth = self.contentLabel.frame.size.width;
        
        super.layoutSubviews()
    }
    
    ///
    /// Setup constraints for each view
    ///
    
    override func setupConstraints(){
        self.contentScrollView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0))
        let subviewsScroll = (self.contentScrollView.subviews as NSArray)
        self.contentView.autoPinEdgeToSuperviewEdge(.Top, withInset: 0.0)
        self.contentView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0.0)
        self.contentView.autoSetDimension(ALDimension.Width, toSize: UIScreen.mainScreen().bounds.size.width)
        self.contentView.autoSetDimension(ALDimension.Height, toSize: UIScreen.mainScreen().bounds.size.height)

        self.pageControl.autoPinEdge(.Top, toEdge: .Bottom, ofView: self.contentImagesScrollView, withOffset: 0.0)
        self.pageControl.autoPinEdgeToSuperviewEdge(.Left, withInset:0.0)
        self.pageControl.autoSetDimension(ALDimension.Width, toSize: Constants.SIZE_GALLERY_ITEM)
        
        self.titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: self.pageControl, withOffset: 10.0)
        self.titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Constants.MARGIN_DETAIL)
        self.subtitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: self.titleLabel, withOffset: 10.0)
        self.subtitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Constants.MARGIN_DETAIL)
        self.contentLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: self.subtitleLabel, withOffset: 10.0)
        self.contentLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Constants.MARGIN_DETAIL)
        self.locationHiddenConstraints = NSLayoutConstraint.autoCreateAndInstallConstraints({ () -> Void in
            
            self.contentImagesScrollView.autoPinEdgeToSuperviewEdge(.Left, withInset: Constants.MARGIN_DETAIL)
            self.contentImagesScrollView.autoPinEdgeToSuperviewEdge(.Top, withInset: Constants.MARGIN_DETAIL)
            self.contentImagesScrollView.autoSetDimension(ALDimension.Width, toSize: Constants.SIZE_GALLERY_ITEM)
            self.contentImagesScrollView.autoSetDimension(ALDimension.Height, toSize: Constants.SIZE_GALLERY)
            self.contentImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0.0)
            self.contentImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 0.0)
        })
        
        self.locationHiddenConstraints.autoRemoveConstraints()
    }
    
    ///
    /// Update constraints when is necessary
    ///
    
    override func changeConstraints(){
        let heigth = self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height
        self.contentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.contentScrollView.bounds), heigth)
    }
    
    ///
    /// initializing views
    ///
    /// 1) Create all views using "PureLayout framework"
    /// 2) Add all subviews
    /// 3) Add styles for each view
    
    override func initialize() {
        createSubViews()
        addSubviews()
        addStyles()
    }
    
    private func createSubViews(){
        self.contentImagesScrollView = UIScrollView.newAutoLayoutView()
        self.contentView = UIView.newAutoLayoutView()
        self.contentImageView = UIView.newAutoLayoutView()
        self.contentScrollView = UIScrollView.newAutoLayoutView()
        self.titleLabel = UILabel.newAutoLayoutView()
        self.subtitleLabel = UILabel.newAutoLayoutView()
        self.contentLabel = UILabel.newAutoLayoutView()
        self.pageControl = UIPageControl.newAutoLayoutView()
    }
    
    private func addSubviews(){
        self.contentImagesScrollView.addSubview(self.contentImageView)
        self.contentView.addSubview(self.contentImagesScrollView)
        self.contentView.addSubview(self.pageControl)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentScrollView.addSubview(self.contentView)
        self.addSubview(self.contentScrollView)
    }
    
    private func addStyles(){
        self.backgroundColor = UIColor.whiteColor()
        self.contentView.clipsToBounds = false
        self.titleLabel.textColor = AppStyles.primaryColorApp()
        self.subtitleLabel.textColor = UIColor.blackColor()
        self.contentLabel.textColor = UIColor.blackColor()
        self.contentView.hidden = false
        self.contentImageView.backgroundColor = UIColor.blackColor()
        self.contentImagesScrollView.pagingEnabled = true
        self.pageControl.currentPageIndicatorTintColor = AppStyles.primaryColorApp()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.contentImagesScrollView.delegate = self;
    }
    
    //MARK:- Public
    
    ///
    /// Display content with fade animation
    ///
    
    func showWithAnimation(){
        self.contentView.hidden = false
        UIView.transitionWithView(self.contentView, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
            }, completion: { (finish:Bool) -> Void in
        })
    }
    
    ///
    /// Create Carrousel from array
    ///
    /// :param: images: array with model wich contains image url
    ///
    
    func createCarrouselWithImages(images:NSArray){
        
        if images.count == 0{
            return
        }
        
        self.locationHiddenConstraints.autoInstallConstraints()
        
        for eventImage in images{
            if let eventImageRest = eventImage as? EventImage{
                for eventImagelink in eventImageRest.links{
                    if let imageLink = eventImagelink as? EventImageLink{
                        if imageLink.href != nil{
                            let request = NSURLRequest(URL: NSURL(string: imageLink.href)!) as NSURLRequest
                            let imageView = UIImageView.newAutoLayoutView()
                            imageView.contentMode = .ScaleAspectFit
                            imageView.setImageWithURLRequest(request, placeholderImage:nil , success: { (request:NSURLRequest,response: NSHTTPURLResponse, image:UIImage) -> Void in
                                imageView.image = image
                                UIView.transitionWithView(imageView, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
                                    }, completion: { (finish:Bool) -> Void in
                                })
                                }) { (request:NSURLRequest, response:NSHTTPURLResponse, error:NSError) -> Void in
                            }
                            
                            imageView.autoSetDimension(.Width, toSize:Constants.SIZE_GALLERY_ITEM)
                            imageView.autoSetDimension(.Height, toSize: CGFloat(Constants.SIZE_GALLERY))
                            
                            self.contentImageView.addSubview(imageView)
                        }
                    }
                }
            }
        }
        
        let subviews = (self.contentImageView.subviews as NSArray)
        let size = Constants.SIZE_GALLERY_ITEM * CGFloat(subviews.count)
        subviews.autoDistributeViewsAlongAxis(.Horizontal, alignedTo:.Top, withFixedSpacing: 0.0, insetSpacing: false, matchedSizes: false)
        subviews.autoAlignViewsToEdge(.Bottom)
        self.contentImageView.autoSetDimension(ALDimension.Width, toSize:size)
        self.contentImageView.autoSetDimension(ALDimension.Height, toSize: Constants.SIZE_GALLERY)
        self.contentImagesScrollView.contentSize = CGSizeMake(size, Constants.SIZE_GALLERY)
        self.pageControl.numberOfPages = subviews.count
        self.pageControl.currentPage = 0;
    }
    
    
    //MARK:- UISCrollViewDelegate
    
    ///
    /// Move Page indicator when is scrolled
    ///
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        let indexPage = Int(scrollView.contentOffset.x/Constants.SIZE_GALLERY_ITEM);
        self.pageControl.currentPage = indexPage;
    }
}
