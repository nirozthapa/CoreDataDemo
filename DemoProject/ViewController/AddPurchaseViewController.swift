//
//  AddPurchaseViewController.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/2/20.
//

import UIKit
import FloatingButtonPOP_swift
class AddPurchaseViewController: PopupViewController{
  
   
    var IsFromDashboard: Bool? = false
    @IBOutlet weak var lblKey: UITextField!
    @IBOutlet weak var lblID: UITextField!
    @IBOutlet weak var lbldata: UITextField!
    @IBOutlet weak var lblPurchaseHeading: UILabel!
    var headerText : String?
    var purchaseId: Int?
    override func viewDidLoad() {
        print("loading purchase view controller")
        self.changePlaceHolderNames()

    }
    
    func changePlaceHolderNames(){
        self.lblPurchaseHeading.text = self.headerText
        if(IsFromDashboard == false){
            lblID.text = "Enter item id"
            lblKey.text = "Enter item key"
            lbldata.text = "Enter item data"
        }else{

        }
    }
    
   
    
    @IBAction func saveData(_ sender: Any) {
        if(IsFromDashboard == false){
            CoreDataHelper.shared.saveItemsToPurchase(purchaseId: self.purchaseId!, product_item_id: 1, transient_identifier: "hello", active_flag: true)
        }else{
            CoreDataHelper.shared.savePurchase(id: 1, note: "Hallowen", device_key: "Coming")


        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
