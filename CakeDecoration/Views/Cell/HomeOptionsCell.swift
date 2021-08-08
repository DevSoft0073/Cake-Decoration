//
//  HomeOptionsCell.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//

import UIKit

class HomeOptionsCell: UITableViewCell {

    @IBOutlet weak var mainVW: Gradient!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
