//
//  AccountAPI.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/8.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation
import Alamofire

class AccountAPI {
    static let module = "string"
        
    /*
    static func getActivityResult(id: String, completionHandler: ([OptionResult]?, MyError?) -> Void) {
        AlamofireManagerProxy.sharedInstance.request(.GET, "\(self.module)/\(id)/vote").responseMyArray(completionHandler)
    }
    
    static func getActivities(lastId: String, numOfItems: Int, completionHandler: ([Activity]?, MyError?) -> Void) {
        AlamofireManagerProxy.sharedInstance.request(.GET, "\(self.module)").responseMyArray(completionHandler)
    }
    
    static func getActivityById<T: Activity>(id: String, completionHandler: (T?, MyError?) -> Void) {
        AlamofireManagerProxy.sharedInstance.request(.GET, "\(self.module)/\(id)").responseMyObject(completionHandler)
    }
    
    static func vote(id: String, optionIndexes: [Int], completionHandler: (SimpleResponseResult?, MyError?) -> Void) {
        AlamofireManagerProxy.sharedInstance.request(.POST, "\(self.module)/\(id)/vote", parameters: ["options": optionIndexes]).responseMyObject(completionHandler)
    }
    
    static func createNewActivities(parameters: [String: AnyObject]?, completionHandler: ([Activity]?, MyError?) -> Void) {
        AlamofireManagerProxy.sharedInstance.request(.POST, "\(self.module)", parameters: parameters, encoding: .JSON).responseMyArray(completionHandler)
    }
    */
}
