//
//  MapView.swift
//  IsisCalendar
//
//  Created by Jorge Sanmartin on 10/09/15.
//  Copyright (c) 2015 isis. All rights reserved.
//
import MapKit

class MapView: BaseView {
    
    var mapView: MKMapView!
    
    override func setupConstraints(){
        self.mapView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
    }
    
    override func changeConstraints(){
        
    }
    
    override func initialize() {
        createSubViews()
        addSubviews()
        addStyles()
    }
    
    func createSubViews(){
        self.mapView = MKMapView.newAutoLayoutView()
    }
    
    func addSubviews(){
        self.addSubview(self.mapView)
    }
    
    func addStyles(){

    }
}
