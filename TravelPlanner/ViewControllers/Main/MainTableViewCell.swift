//
//  MainTableViewCell.swift
//  TravelPlanner
//
//  Created by Thanakorn Amnajsatit on 25/1/2563 BE.
//  Copyright © 2563 GAS. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var airlineLabel: UILabel!
    @IBOutlet weak var hotelLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
