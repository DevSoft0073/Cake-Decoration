//
//  CustomerListingCell.swift
//  CakeDecoration
//
//  Created by MyMac on 14/08/21.
//

import UIKit

class CustomerListingCell: UITableViewCell {

    @IBOutlet weak var btnDeliver: UIButton!
    @IBOutlet weak var btnReady: UIButton!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var LblDate: UILabel!
    @IBOutlet weak var lblTotalCOst: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var cutomerName: UILabel!
    @IBOutlet weak var lblOrder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
