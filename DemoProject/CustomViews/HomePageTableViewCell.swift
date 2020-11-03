//
//  HomePageTableViewCell.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/2/20.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_po_id: UILabel!
    @IBOutlet weak var lbl_total_items: UILabel!
    @IBOutlet weak var lbl_lastUpadte: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
