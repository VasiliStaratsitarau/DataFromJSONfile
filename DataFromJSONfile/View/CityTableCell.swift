//
//  TableViewCell.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 25/08/2022.
//

import UIKit

class myCell: UITableViewCell {
    
    var cityLabel: UILabel!
    var coordLabel: UILabel!
    
    func setUpCell() {
        cityLabel = UILabel(frame: CGRect(x: 28, y: 8, width: 200, height: 30))
        coordLabel = UILabel(frame: CGRect(x: 28, y: 42, width: 400, height: 30))
        contentView.addSubview(cityLabel)
        contentView.addSubview(coordLabel)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.removeFromSuperview()
        coordLabel.removeFromSuperview()
    }
}



