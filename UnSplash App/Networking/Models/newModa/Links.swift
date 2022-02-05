//
//  Links.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct Links: Codable {

	let selfField: String
	let html: String
	let photos: String
	let likes: String
	let portfolio: String
	let following: String
	let followers: String

	private enum CodingKeys: String, CodingKey {
		case selfField = "self"
		case html = "html"
		case photos = "photos"
		case likes = "likes"
		case portfolio = "portfolio"
		case following = "following"
		case followers = "followers"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		selfField = try values.decode(String.self, forKey: .selfField)
		html = try values.decode(String.self, forKey: .html)
		photos = try values.decode(String.self, forKey: .photos)
		likes = try values.decode(String.self, forKey: .likes)
		portfolio = try values.decode(String.self, forKey: .portfolio)
		following = try values.decode(String.self, forKey: .following)
		followers = try values.decode(String.self, forKey: .followers)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(selfField, forKey: .selfField)
		try container.encode(html, forKey: .html)
		try container.encode(photos, forKey: .photos)
		try container.encode(likes, forKey: .likes)
		try container.encode(portfolio, forKey: .portfolio)
		try container.encode(following, forKey: .following)
		try container.encode(followers, forKey: .followers)
	}

}