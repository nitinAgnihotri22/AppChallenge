//
//	MoviesList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MoviesList{

    var response : Bool!
    var error : String!
	var search : [Search]!
	var totalResults : String!
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        response = dictionary["Response"] as? Bool
        error = dictionary["Error"] as? String
		search = [Search]()
		if let searchArray = dictionary["Search"] as? [[String:Any]]{
			for dic in searchArray{
				let value = Search(fromDictionary: dic)
				search.append(value)
			}
		}
		totalResults = dictionary["totalResults"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if response != nil{
            dictionary["Response"] = response
        }
        if error != nil{
            dictionary["Error"] = error
        }
		if search != nil {
            
			var dictionaryElements = [[String:Any]]()
			for searchElement in search {
				dictionaryElements.append(searchElement.toDictionary())
			}
			dictionary["Search"] = dictionaryElements
		}
		if totalResults != nil{
			dictionary["totalResults"] = totalResults
		}
		return dictionary
	}

}
