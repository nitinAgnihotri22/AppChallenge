//
//	MoviesDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MoviesDetail {

	var actors : String!
	var awards : String!
	var country : String!
	var director : String!
	var genre : String!
	var language : String!
	var metascore : String!
	var plot : String!
	var poster : String!
	var rated : String!
	var ratings : [Rating]!
	var released : String!
	var response : Bool!
	var runtime : String!
	var title : String!
	var type : String!
	var writer : String!
	var year : String!
	var imdbID : String!
	var imdbRating : String!
	var imdbVotes : String!
	var totalSeasons : String!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		actors = dictionary["Actors"] as? String
		awards = dictionary["Awards"] as? String
		country = dictionary["Country"] as? String
		director = dictionary["Director"] as? String
		genre = dictionary["Genre"] as? String
		language = dictionary["Language"] as? String
		metascore = dictionary["Metascore"] as? String
		plot = dictionary["Plot"] as? String
		poster = dictionary["Poster"] as? String
		rated = dictionary["Rated"] as? String
		ratings = [Rating]()
		if let ratingsArray = dictionary["Ratings"] as? [[String:Any]]{
			for dic in ratingsArray{
				let value = Rating(fromDictionary: dic)
				ratings.append(value)
			}
		}
		released = dictionary["Released"] as? String
		response = dictionary["Response"] as? Bool
		runtime = dictionary["Runtime"] as? String
		title = dictionary["Title"] as? String
		type = dictionary["Type"] as? String
		writer = dictionary["Writer"] as? String
		year = dictionary["Year"] as? String
		imdbID = dictionary["imdbID"] as? String
		imdbRating = dictionary["imdbRating"] as? String
		imdbVotes = dictionary["imdbVotes"] as? String
		totalSeasons = dictionary["totalSeasons"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if actors != nil{
			dictionary["Actors"] = actors
		}
		if awards != nil{
			dictionary["Awards"] = awards
		}
		if country != nil{
			dictionary["Country"] = country
		}
		if director != nil{
			dictionary["Director"] = director
		}
		if genre != nil{
			dictionary["Genre"] = genre
		}
		if language != nil{
			dictionary["Language"] = language
		}
		if metascore != nil{
			dictionary["Metascore"] = metascore
		}
		if plot != nil{
			dictionary["Plot"] = plot
		}
		if poster != nil{
			dictionary["Poster"] = poster
		}
		if rated != nil{
			dictionary["Rated"] = rated
		}
		if ratings != nil{
			var dictionaryElements = [[String:Any]]()
			for ratingsElement in ratings {
				dictionaryElements.append(ratingsElement.toDictionary())
			}
			dictionary["Ratings"] = dictionaryElements
		}
		if released != nil{
			dictionary["Released"] = released
		}
		if response != nil{
			dictionary["Response"] = response
		}
		if runtime != nil{
			dictionary["Runtime"] = runtime
		}
		if title != nil{
			dictionary["Title"] = title
		}
		if type != nil{
			dictionary["Type"] = type
		}
		if writer != nil{
			dictionary["Writer"] = writer
		}
		if year != nil{
			dictionary["Year"] = year
		}
		if imdbID != nil{
			dictionary["imdbID"] = imdbID
		}
		if imdbRating != nil{
			dictionary["imdbRating"] = imdbRating
		}
		if imdbVotes != nil{
			dictionary["imdbVotes"] = imdbVotes
		}
		if totalSeasons != nil{
			dictionary["totalSeasons"] = totalSeasons
		}
		return dictionary
	}

}
