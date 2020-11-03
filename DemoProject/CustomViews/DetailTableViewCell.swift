//
//  DetailTableViewCell.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/3/20.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblItemHeader: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblItemID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
