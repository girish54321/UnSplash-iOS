//
//  Urls.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct Urls: Codable {

	let raw: String
	let full: String
	let regular: String
	let small: String
	let thumb: String

	private enum CodingKeys: String, CodingKey {
		case raw = "raw"
		case full = "full"
		case regular = "regular"
		case small = "small"
		case thumb = "thumb"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		raw = try values.decode(String.self, forKey: .raw)
		full = try values.decode(String.self, forKey: .full)
		regular = try values.decode(String.self, forKey: .regular)
		small = try values.decode(String.self, forKey: .small)
		thumb = try values.decode(String.self, forKey: .thumb)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(raw, forKey: .raw)
		try container.encode(full, forKey: .full)
		try container.encode(regular, forKey: .regular)
		try container.encode(small, forKey: .small)
		try container.encode(thumb, forKey: .thumb)
	}

}