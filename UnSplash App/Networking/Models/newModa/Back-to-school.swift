//
//  Back-to-school.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct Back-to-school: Codable {

	let status: String
	let approvedOn: String

	private enum CodingKeys: String, CodingKey {
		case status = "status"
		case approvedOn = "approved_on"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decode(String.self, forKey: .status)
		approvedOn = try values.decode(String.self, forKey: .approvedOn)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(status, forKey: .status)
		try container.encode(approvedOn, forKey: .approvedOn)
	}

}
