//
//  AddPurchaseViewController.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/2/20.
//

import UIKit
import FloatingButtonPOP_swift
class AddPurchaseViewController: PopupViewController{
   
    
    @IBOutlet weak var lblPurchaseHeading: UILabel!
    var headerText : String?
    
    override func viewDidLoad() {
        print("loading purchase view controller")
        self.lblPurchaseHeading.text = self.headerText

    }
    
    
}
