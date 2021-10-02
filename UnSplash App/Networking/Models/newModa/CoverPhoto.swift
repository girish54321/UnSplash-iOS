//
//  CoverPhoto.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct CoverPhoto: Codable {

	let id: String
	let createdAt: String
	let updatedAt: String
	let promotedAt: String
	let width: Int
	let height: Int
	let color: String
	let blurHash: String
	let description: String
	let altDescription: String
	let urls: Urls
	let links: Links
	let categories: [Any]
	let likes: Int
	let likedByUser: Bool
	let currentUserCollections: [Any]
	let sponsorship: Any
	let topicSubmissions: TopicSubmissions
	let user: User

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case promotedAt = "promoted_at"
		case width = "width"
		case height = "height"
		case color = "color"
		case blurHash = "blur_hash"
		case description = "description"
		case altDescription = "alt_description"
		case urls = "urls"
		case links = "links"
		case categories = "categories"
		case likes = "likes"
		case likedByUser = "liked_by_user"
		case currentUserCollections = "current_user_collections"
		case sponsorship = "sponsorship"
		case topicSubmissions = "topic_submissions"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(String.self, forKey: .id)
		createdAt = try values.decode(String.self, forKey: .createdAt)
		updatedAt = try values.decode(String.self, forKey: .updatedAt)
		promotedAt = try values.decode(String.self, forKey: .promotedAt)
		width = try values.decode(Int.self, forKey: .width)
		height = try values.decode(Int.self, forKey: .height)
		color = try values.decode(String.self, forKey: .color)
		blurHash = try values.decode(String.self, forKey: .blurHash)
		description = try values.decode(String.self, forKey: .description)
		altDescription = try values.decode(String.self, forKey: .altDescription)
		urls = try values.decode(Urls.self, forKey: .urls)
		links = try values.decode(Links.self, forKey: .links)
		categories = [] // TODO: Add code for decoding `categories`, It was empty at the time of model creation.
		likes = try values.decode(Int.self, forKey: .likes)
		likedByUser = try values.decode(Bool.self, forKey: .likedByUser)
		currentUserCollections = [] // TODO: Add code for decoding `currentUserCollections`, It was empty at the time of model creation.
		sponsorship = nil // TODO: Add code for decoding `sponsorship`, It was null at the time of model creation.
		topicSubmissions = try values.decode(TopicSubmissions.self, forKey: .topicSubmissions)
		user = try values.decode(User.self, forKey: .user)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(createdAt, forKey: .createdAt)
		try container.encode(updatedAt, forKey: .updatedAt)
		try container.encode(promotedAt, forKey: .promotedAt)
		try container.encode(width, forKey: .width)
		try container.encode(height, forKey: .height)
		try container.encode(color, forKey: .color)
		try container.encode(blurHash, forKey: .blurHash)
		try container.encode(description, forKey: .description)
		try container.encode(altDescription, forKey: .altDescription)
		try container.encode(urls, forKey: .urls)
		try container.encode(links, forKey: .links)
		// TODO: Add code for encoding `categories`, It was empty at the time of model creation.
		try container.encode(likes, forKey: .likes)
		try container.encode(likedByUser, forKey: .likedByUser)
		// TODO: Add code for encoding `currentUserCollections`, It was empty at the time of model creation.
		// TODO: Add code for encoding `sponsorship`, It was null at the time of model creation.
		try container.encode(topicSubmissions, forKey: .topicSubmissions)
		try container.encode(user, forKey: .user)
	}

}