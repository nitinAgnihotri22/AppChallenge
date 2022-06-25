//
//  MoviewListVM.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import UIKit

protocol MovieListModelDelegate: NSObjectProtocol {
    func fetchSuccess()
    func fetchError(error:Error?)
}

class MoviewListVM: NSObject {
    
    weak var delegate:MovieListModelDelegate?

    func callFuncToGetMoviewList(_ url:String, completionBlock: ((MoviesList?, Error?) -> Void)?) {
        
        ServiceHelper.request(params: nil, method: .get, apiURL: url) { responseObj, error, status in
            if error == nil {
                let res = responseObj as? [String:Any]
                if let mov = res {
                    let moviesList = MoviesList.init(fromDictionary: mov)
                    completionBlock!(moviesList,nil)
                }
            } else {
                completionBlock!(nil,error)
            }
        }
    }
}
