//
//  RecordingCell.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/29.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class RecordingCell: UITableViewCell {
    
    @IBOutlet var carid: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var location: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
