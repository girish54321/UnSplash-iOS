//
//  User.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct User: Codable {

	let id: String
	let updatedAt: String
	let username: String
	let name: String
	let firstName: String
	let lastName: String
	let twitterUsername: String
	let portfolioUrl: String
	let bio: String
	let location: String
	let links: Links
	let profileImage: ProfileImage
	let instagramUsername: String
	let totalCollections: Int
	let totalLikes: Int
	let totalPhotos: Int
	let acceptedTos: Bool
	let forHire: Bool
	let social: Social

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case updatedAt = "updated_at"
		case username = "username"
		case name = "name"
		case firstName = "first_name"
		case lastName = "last_name"
		case twitterUsername = "twitter_username"
		case portfolioUrl = "portfolio_url"
		case bio = "bio"
		case location = "location"
		case links = "links"
		case profileImage = "profile_image"
		case instagramUsername = "instagram_username"
		case totalCollections = "total_collections"
		case totalLikes = "total_likes"
		case totalPhotos = "total_photos"
		case acceptedTos = "accepted_tos"
		case forHire = "for_hire"
		case social = "social"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(String.self, forKey: .id)
		updatedAt = try values.decode(String.self, forKey: .updatedAt)
		username = try values.decode(String.self, forKey: .username)
		name = try values.decode(String.self, forKey: .name)
		firstName = try values.decode(String.self, forKey: .firstName)
		lastName = try values.decode(String.self, forKey: .lastName)
		twitterUsername = try values.decode(String.self, forKey: .twitterUsername)
		portfolioUrl = try values.decode(String.self, forKey: .portfolioUrl)
		bio = try values.decode(String.self, forKey: .bio)
		location = try values.decode(String.self, forKey: .location)
		links = try values.decode(Links.self, forKey: .links)
		profileImage = try values.decode(ProfileImage.self, forKey: .profileImage)
		instagramUsername = try values.decode(String.self, forKey: .instagramUsername)
		totalCollections = try values.decode(Int.self, forKey: .totalCollections)
		totalLikes = try values.decode(Int.self, forKey: .totalLikes)
		totalPhotos = try values.decode(Int.self, forKey: .totalPhotos)
		acceptedTos = try values.decode(Bool.self, forKey: .acceptedTos)
		forHire = try values.decode(Bool.self, forKey: .forHire)
		social = try values.decode(Social.self, forKey: .social)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(updatedAt, forKey: .updatedAt)
		try container.encode(username, forKey: .username)
		try container.encode(name, forKey: .name)
		try container.encode(firstName, forKey: .firstName)
		try container.encode(lastName, forKey: .lastName)
		try container.encode(twitterUsername, forKey: .twitterUsername)
		try container.encode(portfolioUrl, forKey: .portfolioUrl)
		try container.encode(bio, forKey: .bio)
		try container.encode(location, forKey: .location)
		try container.encode(links, forKey: .links)
		try container.encode(profileImage, forKey: .profileImage)
		try container.encode(instagramUsername, forKey: .instagramUsername)
		try container.encode(totalCollections, forKey: .totalCollections)
		try container.encode(totalLikes, forKey: .totalLikes)
		try container.encode(totalPhotos, forKey: .totalPhotos)
		try container.encode(acceptedTos, forKey: .acceptedTos)
		try container.encode(forHire, forKey: .forHire)
		try container.encode(social, forKey: .social)
	}

}