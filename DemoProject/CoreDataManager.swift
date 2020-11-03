//
//  CoreDataManager.swift
//  CoreData
//
//  Created by Niroj Thapa on 11/2/20.
//


import Foundation

class CoreDataManager: NSObject {
    
    
    class func getPath(fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        print(fileURL)
        return fileURL.path
    }
    
    class func copyFile(fileName: NSString) {
        let dbPath: String = getPath(fileName: fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            var error : NSError?
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            if (error != nil) {
                print("Database could not be copied. Error occoured.")
            } else {
                print("Database copied successfully")
            }
            
        }
    }
    
}
