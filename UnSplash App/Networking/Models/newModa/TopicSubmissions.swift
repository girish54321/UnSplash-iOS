//
//  TopicSubmissions.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct TopicSubmissions: Codable {

	let back-to-school: Back-to-school
	let business-work: Business-work

	private enum CodingKeys: String, CodingKey {
		case back-to-school = "back-to-school"
		case business-work = "business-work"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		back-to-school = try values.decode(Back-to-school.self, forKey: .back-to-school)
		business-work = try values.decode(Business-work.self, forKey: .business-work)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(back-to-school, forKey: .back-to-school)
		try container.encode(business-work, forKey: .business-work)
	}

}