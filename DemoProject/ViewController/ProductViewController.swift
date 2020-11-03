//
//  ProductViewController.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/3/20.
//

import Foundation
import UIKit
import FloatingButtonPOP_swift
class ProductViewController: PopupViewController,FloaterViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    //MARK: declare properties and delegates
    var model = Response()
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK: Load View properties
    override func viewDidLoad(){
        self.tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        self.addFloatingButton()
    }
    
    
    
    //MARK:TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.model.items!.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != self.model.items!.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.lblItemID.text = "ID:" + String( self.model.items![indexPath.row].id!)
            cell.lblQuantity.text = "Quantity:" + String(self.model.items![indexPath.row].quantity!)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.lblItemHeader.text = "Invoice"
            cell.lblItemID.text = "ID:" + String(self.model.invoices![0].invoice_number!)
            cell.lblQuantity.text = "Status:" + String(self.model.invoices![0].received_status!)
            return cell
        }
        
    }
    
    //MARK: Floating button delegates
    func addFloatingButton(){
        addFloaterMenu(with: [("Add Items", UIImage(named: "Image"))], mainItem: ("", UIImage(named: "Image")), dropShadow: true)
    }
    func userDidTapOnItem(at index: Int, with model: String) {
        let typeSelectionVC = self.storyboard!.instantiateViewController(identifier: "AddPurchaseViewController") as! AddPurchaseViewController
        typeSelectionVC.headerText = "Add new Item"
        typeSelectionVC.modalPresentationStyle = .overFullScreen
        typeSelectionVC.shouldDismissViewOnTapOutside = true
        typeSelectionVC.shouldAddFullOverlay = true
        self.present(typeSelectionVC, animated: true)

    }
    
    
}
