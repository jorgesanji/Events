//
//  EventCell.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class EventCell: BaseUITableViewCell {
    
    // MARK: public
    var title:NSString{
        get{
            return self.titleNew.text!
        }
        set{
            self.titleNew.text = newValue as String
        }
    }
    
    var subTitle:NSString{
        get{
            return self.subtitleNew.text!
        }
        set{
            let htmlNo = newValue.removeHtmlTags()
            self.subtitleNew.text = htmlNo as String
        }
    }
    
    var date:NSString{
        get{
            return self.dateLabel.text!
        }
        set{
            self.dateLabel.text = newValue as String
        }
    }
    
    var imageEvent:NSString{
        get{
            return self.imageEvent;
        }
        set{
            let size =  CGSizeMake(Constants.SIZE_THUMB, Constants.SIZE_THUMB)
            let imagePlaceHolder = UIImage.imageWithColor(UIColor.grayColor(), size: size).cropToCircleWithSize(size)
            let request = NSURLRequest(URL: NSURL(string: newValue as String)!)
            self.imageNewView.setImageWithURLRequest(request, placeholderImage:imagePlaceHolder , success: { (request:NSURLRequest,response: NSHTTPURLResponse, image:UIImage) -> Void in
                self.imageNewView.image = image.cropToCircleWithSize(size);
                UIView.transitionWithView(self.imageNewView, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
                    }, completion: { (finish:Bool) -> Void in
                })
                }) { (request:NSURLRequest, response:NSHTTPURLResponse, error:NSError) -> Void in
                    
            }
        }
    }
    
    // MARK: private
    
    private var titleNew:UILabel!
    private var subtitleNew:UILabel!
    private var dateLabel:UILabel!
    private var container:UIView!
    private var imageNewView:UIImageView!
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
        // need to use to set the preferredMaxLayoutWidth below.
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        
        // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
        // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
        self.titleNew.preferredMaxLayoutWidth =  CGRectGetWidth(self.titleNew.frame)
        self.subtitleNew.preferredMaxLayoutWidth =  CGRectGetWidth(self.subtitleNew.frame)
        
    }
    
    
    override func setupConstraints(){
        
        self.imageNewView.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0)
        self.imageNewView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        self.imageNewView.autoSetDimension(ALDimension.Width, toSize:Constants.SIZE_THUMB)
        self.imageNewView.autoSetDimension(ALDimension.Height, toSize:Constants.SIZE_THUMB)
        
        self.container.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0), excludingEdge: .Left)
        
        self.container.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: self.imageNewView, withOffset: 20.0)
        
        NSLayoutConstraint.autoSetPriority(999, forConstraints: { () -> Void in
            self.titleNew.autoSetContentCompressionResistancePriorityForAxis(ALAxis.Vertical)
        })
        
        self.titleNew.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 0.0)
        self.titleNew.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0.0)
        self.titleNew.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0.0)
        
        self.subtitleNew.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.titleNew)
        
        NSLayoutConstraint.autoSetPriority(999, forConstraints: { () -> Void in
            self.subtitleNew.autoSetContentCompressionResistancePriorityForAxis(ALAxis.Vertical)
        })
        
        self.subtitleNew.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0.0)
        self.subtitleNew.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0.0)        
        
        self.dateLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.subtitleNew)
        
        NSLayoutConstraint.autoSetPriority(999, forConstraints: { () -> Void in
            self.dateLabel.autoSetContentCompressionResistancePriorityForAxis(ALAxis.Vertical)
        })
        
        self.dateLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0.0)
        self.dateLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0.0)
        self.dateLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0.0)
    }
    
    override func changeConstraints(){
        
    }
    
    override func initialize() {
        createSubViews()
        addSubviews()
        addStyles()
    }
    
    func createSubViews(){
        self.imageNewView = UIImageView.newAutoLayoutView()
        self.container = UIView.newAutoLayoutView()
        self.titleNew = UILabel.newAutoLayoutView()
        self.subtitleNew = UILabel.newAutoLayoutView()
        self.dateLabel = UILabel.newAutoLayoutView()
    }
    
    func addSubviews(){
        self.container.addSubview(self.titleNew)
        self.container.addSubview(self.subtitleNew)
        self.container.addSubview(self.dateLabel)
        self.contentView.addSubview(self.container)
        self.contentView.addSubview(self.imageNewView)
    }
    
    func addStyles(){
        self.titleNew.textAlignment = NSTextAlignment.Left
        self.titleNew.textColor = AppStyles.primaryColorApp()
        self.titleNew.numberOfLines = 0
        self.subtitleNew.textAlignment = NSTextAlignment.Left
        self.subtitleNew.numberOfLines = 0
        self.container.backgroundColor = UIColor.clearColor()
        self.imageNewView.contentMode = UIViewContentMode.Center
        self.imageNewView.clipsToBounds = true
        self.dateLabel.font = UIFont.systemFontOfSize(12)
        self.dateLabel.textColor = UIColor.lightGrayColor()
        self.dateLabel.textAlignment = NSTextAlignment.Left
    }
    
    override func compressHeigth()->CGFloat{
        return super.compressHeigth() < 70 ? 70 : super.compressHeigth()
    }
}