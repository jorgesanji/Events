//
//  BaseViewController.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 14/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

class BaseViewController: UIViewController {
    
    ///
    /// Show network error alert
    ///
    
    func showNetworkAlert(){
        var alert = UIAlertController(title: NSLocalizedString("title_error_network", comment: ""), message: NSLocalizedString("message_error_network", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok_button", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
