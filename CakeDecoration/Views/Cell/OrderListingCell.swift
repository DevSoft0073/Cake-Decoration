//
//  OrderListingCell.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//

import UIKit

class OrderListingCell: UITableViewCell {

    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var lblDayTime: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblCakeFlvr: UILabel!
    @IBOutlet weak var lblIceFlvr: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDueDate: UILabel!
    @IBOutlet weak var btnReady: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrder: UILabel!
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
