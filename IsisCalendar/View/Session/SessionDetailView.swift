//
//  SessionDetailView.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 10/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

class SessionDetailView: DetailView {
    
    override func createCarrouselWithImages(images:NSArray){
        
        if images.count == 0{
            return
        }
        
        self.locationHiddenConstraints.autoInstallConstraints()
        
        for sessionImage in images{
            if let sessionImageRest = sessionImage as? SessionImage{
                for sessionImagelink in sessionImageRest.links{
                    if let imageLink = sessionImagelink as? SessionImageLink{
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

}
