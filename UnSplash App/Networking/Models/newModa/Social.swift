//
//  Social.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct Social: Codable {

	let instagramUsername: String
	let portfolioUrl: String
	let twitterUsername: String
	let paypalEmail: Any

	private enum CodingKeys: String, CodingKey {
		case instagramUsername = "instagram_username"
		case portfolioUrl = "portfolio_url"
		case twitterUsername = "twitter_username"
		case paypalEmail = "paypal_email"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		instagramUsername = try values.decode(String.self, forKey: .instagramUsername)
		portfolioUrl = try values.decode(String.self, forKey: .portfolioUrl)
		twitterUsername = try values.decode(String.self, forKey: .twitterUsername)
		paypalEmail = nil // TODO: Add code for decoding `paypalEmail`, It was null at the time of model creation.
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(instagramUsername, forKey: .instagramUsername)
		try container.encode(portfolioUrl, forKey: .portfolioUrl)
		try container.encode(twitterUsername, forKey: .twitterUsername)
		// TODO: Add code for encoding `paypalEmail`, It was null at the time of model creation.
	}

}