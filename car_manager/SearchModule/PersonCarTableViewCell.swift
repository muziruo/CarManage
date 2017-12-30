//
//  PersonCarTableViewCell.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/30.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class PersonCarTableViewCell: UITableViewCell {

    @IBOutlet weak var FirstLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
