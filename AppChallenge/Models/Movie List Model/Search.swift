//
//	Search.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Search{

	var poster : String!
	var title : String!
	var type : String!
	var year : String!
	var imdbID : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		poster = dictionary["Poster"] as? String
		title = dictionary["Title"] as? String
		type = dictionary["Type"] as? String
		year = dictionary["Year"] as? String
		imdbID = dictionary["imdbID"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if poster != nil{
			dictionary["Poster"] = poster
		}
		if title != nil{
			dictionary["Title"] = title
		}
		if type != nil{
			dictionary["Type"] = type
		}
		if year != nil{
			dictionary["Year"] = year
		}
		if imdbID != nil{
			dictionary["imdbID"] = imdbID
		}
		return dictionary
	}

}