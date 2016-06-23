//
//  BaseUITableViewCell.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation
class BaseUITableViewCell: UITableViewCell {
    
    private var didSetupConstraints = false
    
    func setupConstraints(){
        fatalError("setupConstraints has not been implemented")
    }
    
    func changeConstraints(){
        fatalError("changeConstraints has not been implemented")
    }
    
    func initialize(){
        fatalError("initialize has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit(){
        self.didSetupConstraints = false
        initialize()
        setupConstraints()
        self.didSetupConstraints = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func compressHeigth() -> CGFloat{
        return self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.didSetupConstraints = false
    }
    
    override static func requiresConstraintBasedLayout() -> Bool{
        return true
    }
    
    override func updateConstraints(){
        super.updateConstraints()
        if !self.didSetupConstraints{
            setupConstraints()
            self.didSetupConstraints = true
        }else{
            changeConstraints()
        }
    }
}
