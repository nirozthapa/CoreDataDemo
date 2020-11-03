//
//  ViewController.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/2/20.
//

import UIKit
import FloatingButtonPOP_swift
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,FloaterViewDelegate {

    var responseModel = [Response]()
    var viewcontroller = DatabaseHelper()

    func userDidTapOnItem(at index: Int, with model: String) {
        print(index)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let typeSelectionVC = storyboard.instantiateViewController(identifier: "AddPurchaseViewController") as! AddPurchaseViewController
        typeSelectionVC.modalPresentationStyle = .overFullScreen
        typeSelectionVC.shouldDismissViewOnTapOutside = true
        typeSelectionVC.shouldAddFullOverlay = true
        self.present(typeSelectionVC, animated: true)

    }
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomePageTableViewCell", bundle: nil), forCellReuseIdentifier: "HomePageTableViewCell")
        self.addFloatingButton()
        self.loadData()

    }
    
    func loadData(){
        viewcontroller.fetchServerData(completion: { [self](resp,err) -> Void in
            
            if (resp != nil){
                self.responseModel = resp as! [Response]
                DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

            }
            else{
                print("Data could not be retrived from source")
            }
        })

    }
    func addFloatingButton(){
        addFloaterMenu(with: [("Add Purchase", UIImage(named: "Image"))], mainItem: ("", UIImage(named: "Image")), dropShadow: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.responseModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTableViewCell", for: indexPath) as! HomePageTableViewCell
        cell.lbl_po_id.text = String(self.responseModel[indexPath.row].id!)
        cell.lbl_lastUpadte.text = self.responseModel[indexPath.row].last_updated
        cell.lbl_total_items.text = String((self.responseModel[indexPath.row].items?.count)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navVC = self.storyboard!.instantiateViewController(identifier: "ProductViewController") as! ProductViewController
        navVC.model = self.responseModel[indexPath.row]
        self.present(navVC, animated: true)

        
    }
}

