//
//  CarDetailTableViewCell.swift
//  car_manager
//
//  Created by 李祎喆 on 2017/12/26.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
