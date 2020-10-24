//
//  FooterView.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 05/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

final class FooterView: UICollectionReusableView, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }
    
    private func setup() {
        backgroundColor = .footerColor
        showSpinner()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                backgroundColor = .footerColor
            }
        }
    }
}
