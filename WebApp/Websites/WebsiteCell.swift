//
//  TableViewCell.swift
//  WebApp
//
//  Created by tamzimun on 02.07.2022.
//

import UIKit

class WebsiteCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    func configure(with website: Website) {
        title.text = website.title

    }
}
