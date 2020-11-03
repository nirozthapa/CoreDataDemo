//
//  Response.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/2/20.
//

import Foundation
class Response: NSObject,Codable{
    var id: Int?
    var supplier_id: Int?
    var purchase_order_number:String?
    var stock_purchase_process_id:[Int]?
    var issue_date: String?
    var items: [ItemDetails]?
    var invoices:[InvoiceDetails]?
    var cancellations:[CancellationDetails]?
    var status: Int?
    var active_flag: Bool?
    var last_updated: String?
    var last_updated_user_entity_id:Int?
    var sent_date:String?
    var server_timestamp:Int?
    var device_key:String?
    var approval_status:Int?
    var preferred_delivery_date:String?
    var delivery_note:String?

}

class ItemDetails: NSObject,Codable {
    var id: Int?
    var product_item_id: Int?
    var quantity: Int?
    var last_updated_user_entity_id: Int?
    var transient_identifier: String?
    var active_flag: Bool?
    var last_updated: String?
}
class InvoiceDetails: NSObject,Codable{
    var id: Int?
    var invoice_number: String?
    var received_status : Int?
    var created:String?
    var last_updated_user_entity_id: Int?
    var transient_identifier: String?
    var receipts:[ReceiptsDetails]?
    var receipt_sent_date: String?
    var active_flag: Bool?
    var last_updated: String?
}
class ReceiptsDetails: NSObject,Codable{
    var details : ItemDetails?
    var received_quantity: Int?
    var created: String?
    var sentDate: String?
}

class CancellationDetails: NSObject,Codable{
    var id: Int?
    var product_item_id: Int?
    var ordered_quantity: Int?
    var last_updated_user_entity_id: Int?
    var created:String?
    var transient_identifier: String?

}
