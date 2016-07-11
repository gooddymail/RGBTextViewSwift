//
//  RGBTextView.swift
//  RGBTextViewSwift
//
//  Created by Katchapon Poolpipat on 7/11/2559 BE.
//  Copyright © 2559 Katchapon Poolpipat. All rights reserved.
//

import UIKit

class RGBTextView: UITextView {
    
    // MARK: - RGBTextView Property
    // TODO: Add PlaceHolder
    
    @IBInspectable var maxHeight: CGFloat = 0
    @IBInspectable var minHeight: CGFloat = 0
    private var heightConstraint: NSLayoutConstraint?
    private var maxHeightConstraint: NSLayoutConstraint?
    
    
    // MARK: - UITextView Overide Method
    
    override var bounds: CGRect {
        didSet {
            super.bounds = bounds
            
            if self.contentSize.height <= (self.bounds.size.height + 1) {
                self.contentOffset = CGPointZero
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configureTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTextView()
    }
    
    deinit {
        removeTextViewNotificationObservers()
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sizeThatFits = self.sizeThatFits(self.frame.size)
        var newHeight = sizeThatFits.height
        
        if maxHeight != 0 {
            newHeight = min(newHeight, maxHeight)
        }
        
        if  minHeight != 0 {
            newHeight = max(newHeight, minHeight)
        }
        
        self.heightConstraint?.constant = newHeight
        self.superview?.layoutSubviews()
        
    }
    
    // MARK: - RGBTextView Method
    
    private func configureTextView() {
        removeAssociateConstraints()
        
        if minHeight != 0 {
            
            heightConstraint =  NSLayoutConstraint(item: self,
                                                   attribute: .Height,
                                                   relatedBy: .Equal,
                                                   toItem: nil,
                                                   attribute: .NotAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: minHeight)
            self.addConstraint(heightConstraint!)
        }
        
        if maxHeight != 0 {
            maxHeightConstraint = NSLayoutConstraint(item: self,
                                                     attribute: .Height,
                                                     relatedBy: .LessThanOrEqual,
                                                     toItem: nil,
                                                     attribute: .NotAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: maxHeight)
        }
        
        addTextViewNotificationObservers()
    }
    
    private func removeAssociateConstraints() {
        for constraint in constraints {
            removeConstraint(constraint)
        }
    }
    
    private func addTextViewNotificationObservers() {
        
        let selector = #selector(self.didReciveTextViewNotification)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: selector,
                                                         name: UITextViewTextDidChangeNotification,
                                                         object: self)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: selector,
                                                         name: UITextViewTextDidBeginEditingNotification,
                                                         object: self)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: selector,
                                                         name: UITextViewTextDidEndEditingNotification,
                                                         object: self)
    }
    
    private func removeTextViewNotificationObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: self)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidBeginEditingNotification, object: self)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidEndEditingNotification, object: self)
    }
    
    @objc private func didReciveTextViewNotification() {
        self.setNeedsDisplay()
    }
    
    
}





