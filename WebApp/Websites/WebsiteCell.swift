//
//  TableViewCell.swift
//  WebApp
//
//  Created by Aida Moldaly on 02.07.2022.
//

import UIKit

class WebsiteCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    func configure(with website: Website) {
        title.text = website.title

    }
}
