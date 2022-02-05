//
//  ProfileImage.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct ProfileImage: Codable {

	let small: String
	let medium: String
	let large: String

	private enum CodingKeys: String, CodingKey {
		case small = "small"
		case medium = "medium"
		case large = "large"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		small = try values.decode(String.self, forKey: .small)
		medium = try values.decode(String.self, forKey: .medium)
		large = try values.decode(String.self, forKey: .large)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(small, forKey: .small)
		try container.encode(medium, forKey: .medium)
		try container.encode(large, forKey: .large)
	}

}