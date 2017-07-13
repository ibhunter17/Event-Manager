//
//  CustomCelTableViewCell.swift
//  Event-Manager
//
//  Created by Nitish Dang on 2017-07-13.
//  Copyright © 2017 Nitish Dang. All rights reserved.
//

import UIKit

class CustomCelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventPicture: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
