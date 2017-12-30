//
//	Info.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Info{

	var car : Car!
	var inOutNote : [InOutNote]!
	var owne : Owne!
	var pass : Pas!
	var ticket : [Ticket]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let carData = dictionary["car"] as? [String:Any]{
				car = Car(fromDictionary: carData)
			}
		inOutNote = [InOutNote]()
		if let inOutNoteArray = dictionary["in_out_note"] as? [[String:Any]]{
			for dic in inOutNoteArray{
				let value = InOutNote(fromDictionary: dic)
				inOutNote.append(value)
			}
		}
		if let owneData = dictionary["owne"] as? [String:Any]{
				owne = Owne(fromDictionary: owneData)
			}
		if let passData = dictionary["pass"] as? [String:Any]{
				pass = Pas(fromDictionary: passData)
			}
		ticket = [Ticket]()
		if let ticketArray = dictionary["ticket"] as? [[String:Any]]{
			for dic in ticketArray{
				let value = Ticket(fromDictionary: dic)
				ticket.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if car != nil{
			dictionary["car"] = car.toDictionary()
		}
		if inOutNote != nil{
			var dictionaryElements = [[String:Any]]()
			for inOutNoteElement in inOutNote {
				dictionaryElements.append(inOutNoteElement.toDictionary())
			}
			dictionary["in_out_note"] = dictionaryElements
		}
		if owne != nil{
			dictionary["owne"] = owne.toDictionary()
		}
		if pass != nil{
			dictionary["pass"] = pass.toDictionary()
		}
		if ticket != nil{
			var dictionaryElements = [[String:Any]]()
			for ticketElement in ticket {
				dictionaryElements.append(ticketElement.toDictionary())
			}
			dictionary["ticket"] = dictionaryElements
		}
		return dictionary
	}

}