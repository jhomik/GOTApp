//
//  GoTCell.swift
//  MVVM-C
//
//  Created by Usemobile on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class GoTCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
