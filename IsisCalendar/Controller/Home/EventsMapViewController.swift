//
//  MapViewController.swift
//  IsisCalendar
//
//  Created by Jorge Sanmartin on 10/09/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import MapKit

class EventsMapViewController: BaseViewController, MKMapViewDelegate {
    
    /// override root view
    var Oview: MapView! { return self.view as! MapView }
    
    // MARK:- Properties

    private var titleMap :NSString!
    private var items :NSArray!
    private var alreadyUpdated:Bool;
    
    // MARK:- UIViewController
    
    override func loadView() {
        self.view = MapView()
    }
    
    ///
    /// Constructor
    ///
    /// :param: title: title event
    /// :param: items: items from event 
    
    init(title:NSString, items:NSArray){
        self.alreadyUpdated = false
        super.init(nibName: nil, bundle: nil)
        self.titleMap = title;
        self.items = items;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = self.titleMap as? String
        self.edgesForExtendedLayout = .Bottom
        addAnnotations()
    }
    
    // MARK:- Private
    
    ///
    /// Add event annotation to map
    ///
    
    private func addAnnotations(){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            let arrayAnnotations = NSMutableArray()
            for item in self.items{
                let itemEvent = item as! CDEvent
                var location = CLLocationCoordinate2D(latitude: itemEvent.latitude.doubleValue, longitude: itemEvent.longitude.doubleValue)
                let mapAnnotation = MapAnnotation(coordinate:location , title: itemEvent.title as String, subtitle: itemEvent.subTitle as String)
                arrayAnnotations.addObject(mapAnnotation)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.Oview.mapView.delegate = self;
                self.Oview.mapView.addAnnotations(arrayAnnotations as [AnyObject])
                self.Oview.mapView.showAnnotations(self.Oview.mapView.annotations, animated: true)
                self.Oview.mapView.showsUserLocation = true
            })
        })
    }
    
    
    // MARK:- MapView Delegate
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!{
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "Evesntspin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    ///
    /// When user location is updated then show all annotation on map include user location
    ///
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!){
        if !self.alreadyUpdated{
            self.Oview.mapView.showAnnotations(self.Oview.mapView.annotations, animated: true)
            self.alreadyUpdated = true
        }
    }
}
