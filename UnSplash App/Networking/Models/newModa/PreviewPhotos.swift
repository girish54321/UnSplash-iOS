//
//  PreviewPhotos.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct PreviewPhotos: Codable {

	let id: String
	let createdAt: String
	let updatedAt: String
	let blurHash: String
	let urls: Urls

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case blurHash = "blur_hash"
		case urls = "urls"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(String.self, forKey: .id)
		createdAt = try values.decode(String.self, forKey: .createdAt)
		updatedAt = try values.decode(String.self, forKey: .updatedAt)
		blurHash = try values.decode(String.self, forKey: .blurHash)
		urls = try values.decode(Urls.self, forKey: .urls)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(createdAt, forKey: .createdAt)
		try container.encode(updatedAt, forKey: .updatedAt)
		try container.encode(blurHash, forKey: .blurHash)
		try container.encode(urls, forKey: .urls)
	}

}