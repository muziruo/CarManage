//
//	CarInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CarInfo{

	var info : Info!
	var result : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let infoData = dictionary["info"] as? [String:Any]{
				info = Info(fromDictionary: infoData)
			}
		result = dictionary["result"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if info != nil{
			dictionary["info"] = info.toDictionary()
		}
		if result != nil{
			dictionary["result"] = result
		}
		return dictionary
	}

}