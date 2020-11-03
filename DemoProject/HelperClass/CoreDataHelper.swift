//
//  CoreDataHelper.swift
//  DemoProject
//
//  Created by Niroj Thapa on 11/3/20.
//

import Foundation
import CoreData
import UIKit
class CoreDataHelper {
    var delegate: AppDelegate!
    var context: NSManagedObjectContext!
    static let shared = CoreDataHelper()
    init() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Invalid App Delegate")
        }
        self.delegate = appDel
        self.context = self.delegate.persistentContainer.viewContext
    }
    func savePurchase(id:Int,note:String, device_key:String) -> Bool{
        let purchaseOrdersEntity = NSEntityDescription.entity(forEntityName: "Purchase_orders", in: context)
        let newOrder = NSManagedObject(entity: purchaseOrdersEntity!, insertInto: context) as! Purchase_orders
        newOrder.id = Int16(id)
        newOrder.delivery_note = note
        newOrder.device_key = device_key
        do {
            try context.save()
            return true
        }
        catch (let error) {
            fatalError("Error saving to core data \(error.localizedDescription)")
        }
        
    }
    
    
    func saveItemsToPurchase(purchaseId:Int,product_item_id:Int,transient_identifier:String, active_flag:Bool) -> Bool{
        let purchaseOrdersEntity = NSEntityDescription.entity(forEntityName: "Purchase_orders", in: context)
        let newOrder = NSManagedObject(entity: purchaseOrdersEntity!, insertInto: context) as! Purchase_orders
        let fetchPurchase = NSFetchRequest<NSFetchRequestResult>(entityName: "Purchase_orders")
        fetchPurchase.predicate = NSPredicate(format: "id = %@","\(purchaseId)")
        do{
            let fetch = try context.fetch(fetchPurchase)
            do{
               
                let ItemOrdersEntity = NSEntityDescription.entity(forEntityName: "Items", in: context)
                let newItem = NSManagedObject(entity: ItemOrdersEntity!, insertInto: context) as! Items
                newItem.product_item_id = Int64(product_item_id)
                newItem.transient_identifier = transient_identifier
                newItem.active_flag = active_flag
                do {
                    
                    
                    try context.save()
                    return true
                }
                catch (let error) {
                    fatalError("Error saving to core data \(error.localizedDescription)")
                }
            }catch{
                print("error")
            }
        }catch{
            print("error")
        }
        
        return true
    }
    
    
    func storeCDPurchaseOrderRecord(model: Response) -> Bool {
        let purchaseOrdersEntity = NSEntityDescription.entity(forEntityName: "Purchase_orders", in: context)
        let newOrder = NSManagedObject(entity: purchaseOrdersEntity!, insertInto: context) as! Purchase_orders
        newOrder.id = Int16(model.id!)
        newOrder.supplier_id = Int32(model.supplier_id!)
        newOrder.active_flag = model.active_flag!
        newOrder.status = Int16(model.status!)
        newOrder.last_updated = model.last_updated!
        newOrder.last_updated_user_entity_id = Int16(model.last_updated_user_entity_id!)
        newOrder.sent_date = model.sent_date
        newOrder.server_timestamp = Int16(model.server_timestamp!)
        newOrder.device_key = model.device_key!
        newOrder.approval_status = Int16(model.approval_status!)
        newOrder.preferred_delivery_date = model.preferred_delivery_date!
        newOrder.delivery_note = model.delivery_note!
        
        if let respItems = model.items {
            let itemsEntity = NSEntityDescription.entity(forEntityName: "Items", in: context)
            for respItem in respItems {
                let newItem = NSManagedObject(entity: itemsEntity!, insertInto: context) as! Items
                newItem.id = Int64(respItem.id!)
                newItem.quantity = Int64(respItem.quantity!)
                newItem.last_updated = String(respItem.last_updated!)
                newItem.last_updated_user_entity_id = Int64(respItem.last_updated_user_entity_id!)
                newItem.transient_identifier = String(respItem.transient_identifier!)
                newOrder.addToItems(newItem)
            }
        }
        if let respInvoice = model.invoices {
            let invoiceEntity = NSEntityDescription.entity(forEntityName: "Invoices", in: context)
            for respInv in respInvoice {
                let newInvoice = NSManagedObject(entity: invoiceEntity!, insertInto: context) as! Invoices
                newInvoice.id = Int64(respInv.id!)
                newInvoice.transient_identifier = String(respInv.transient_identifier!)
                newInvoice.last_updated = String(respInv.last_updated!)
                newInvoice.last_updated_user_entity_id = Int32(respInv.last_updated_user_entity_id!)
                newInvoice.invoice_number = String(respInv.invoice_number!)
                
                
                if let invReceipts = respInv.receipts{
                    
                    let recpEntity = NSEntityDescription.entity(forEntityName: "Receipts", in: context)
                    for respRecpit in invReceipts {
                        let newRecpit = NSManagedObject(entity: recpEntity!, insertInto: context) as! Receipts
                        newRecpit.id = Int64(respRecpit.id!)
                        newRecpit.transient_identifier = String(respInv.transient_identifier!)
                        newRecpit.last_updated = String(respInv.last_updated!)
                        newInvoice.addToRecipts(newRecpit)
                        
                    }
                    
                }
                newOrder.addToInvoice(newInvoice)
                
                
            }
        }
        
        do {
            try context.save()
            return true
        }
        catch (let error) {
            fatalError("Error saving to core data \(error.localizedDescription)")
        }
    }
    
    
    func getCDPurchaseOrderRecord() -> [Response]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Purchase_orders")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var purchaseOrders = [Response]()
            for data in result as! [Purchase_orders] {
                let newResponse = Response()
                newResponse.id = Int(data.id)
                newResponse.supplier_id = Int(data.supplier_id)
                newResponse.active_flag = data.active_flag
                newResponse.status = Int(data.status)
                newResponse.last_updated = data.last_updated
                newResponse.last_updated_user_entity_id = Int(data.last_updated_user_entity_id)
                newResponse.sent_date = data.sent_date
                newResponse.server_timestamp = Int(data.server_timestamp)
                newResponse.device_key = data.device_key
                newResponse.approval_status = Int(data.approval_status)
                newResponse.preferred_delivery_date = data.preferred_delivery_date
                newResponse.delivery_note = data.delivery_note
                purchaseOrders.append(newResponse)
            }
            return purchaseOrders
        }
        catch (let error) {
            fatalError("Error retrieving core data \(error.localizedDescription)")
        }
    }
}
