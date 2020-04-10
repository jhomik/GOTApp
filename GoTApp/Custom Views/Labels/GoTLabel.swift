//
//  GoTLabel.swift
//  GoTApp
//
//  Created by Jakub Homik on 08/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class GoTLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    func configure() {
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingTail
        adjustsFontForContentSizeCategory = true
        numberOfLines = 4
    }
}
