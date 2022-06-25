//
//	Rating.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Rating{

	var source : String!
	var value : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]) {
		source = dictionary["Source"] as? String
		value = dictionary["Value"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if source != nil{
			dictionary["Source"] = source
		}
		if value != nil{
			dictionary["Value"] = value
		}
		return dictionary
	}

}
