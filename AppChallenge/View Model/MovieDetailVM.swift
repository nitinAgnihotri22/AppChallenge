//
//  MovieDetailVM.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import Foundation

protocol MovieDetailModelDelegate: NSObjectProtocol {
    func fetchSuccess()
    func fetchError(error:Error?)
}

class MovieDetailVM: NSObject {
    func callFuncToGetMoviewDetail(_ url:String, completionBlock: ((MoviesDetail?, Error?) -> Void)?) {
        ServiceHelper.request(params: nil, method: .get, apiURL: url) { responseObj, error, status in
            if error == nil {
                let res = responseObj as? [String:Any]
                if let mov = res {
                    let movieDetail = MoviesDetail.init(fromDictionary: mov)
                    completionBlock!(movieDetail,nil)
                } else {
                    completionBlock!(nil,error)
                }
            } else {
                completionBlock!(nil,error)
            }
        }
    }
}
