//
//  DatabaseHelper.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/2/20.
//

import Foundation
import UIKit
class DatabaseHelper {
    
    func fetchServerData(completion: @escaping responseBlock) {
        guard let gitUrl = URL(string: "https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders") else { return }
             URLSession.shared.dataTask(with: gitUrl) { (data, response
                 , error) in
                 guard let data = data else { return }
                 do {
                     let decoder = JSONDecoder()
                     let data = try decoder.decode(Array<Response>.self, from: data)
                    print(data ?? "Empty Name")
                    completion(data,error)
                     
                 } catch let err {
                    completion(response,error)

                 }
                 }.resume()
    }
    
    //fetching data from server
    func fetchData(completion: @escaping responseBlock){
          if let url = URL(string: "https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                    let res = try JSONDecoder().decode(Array<Response>.self, from: data)
                  } catch let error {
                    
                  }
               }

           }.resume()

        }
        completion(true,nil)
    }
}
