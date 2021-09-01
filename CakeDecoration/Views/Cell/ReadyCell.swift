//
//  ReadyCell.swift
//  CakeDecoration
//
//  Created by MyMac on 8/22/21.
//

import UIKit

class ReadyCell: UITableViewCell {

    @IBOutlet weak var btnReady: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
