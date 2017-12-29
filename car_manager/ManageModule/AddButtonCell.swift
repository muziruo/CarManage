//
//  AddButtonCell.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/29.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class AddButtonCell: UITableViewCell {
    
    @IBOutlet var button:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.blue
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1.5
        button.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
