//
//  DailyInventoryCell.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//

import UIKit

class DailyInventoryCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var displayFld: UITextField!
    @IBOutlet weak var walkinFld: UITextField!
    @IBOutlet weak var otherStorageFld: UITextField!
    @IBOutlet weak var totalFld: UITextField!
    @IBOutlet weak var priceFld: UITextField!
    @IBOutlet weak var producedFld: UITextField!
    @IBOutlet weak var varianceFld: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayFld.keyboardType = .numberPad
        walkinFld.keyboardType = .numberPad
        otherStorageFld.keyboardType = .numberPad
        totalFld.keyboardType = .numberPad
        priceFld.keyboardType = .numberPad
        producedFld.keyboardType = .numberPad
        totalFld.isUserInteractionEnabled = false
        varianceFld.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
