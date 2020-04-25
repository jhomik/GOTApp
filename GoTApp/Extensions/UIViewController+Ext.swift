//
//  UIViewController+Ext.swift
//  GoTApp
//
//  Created by Jakub Homik on 08/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation
import SafariServices

extension UIViewController {
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .popover
        present(safariVC, animated: true)
    }
}
