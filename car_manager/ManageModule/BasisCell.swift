//
//  AddUserTableViewCell.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/22.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class BasisCell: UITableViewCell {
    
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
