//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 29, 2021
//
import Foundation

struct RootClass: Codable {

	let id: String
	let slug: String
	let title: String
	let description: String
	let publishedAt: String
	let updatedAt: String
	let startsAt: String
	let endsAt: String
	let onlySubmissionsAfter: Any
	let featured: Bool
	let totalPhotos: Int
	let currentUserContributions: [Any]
	let totalCurrentUserSubmissions: Any
	let links: Links
	let status: String
	let owners: [Owners]
	let coverPhoto: CoverPhoto
	let previewPhotos: [PreviewPhotos]

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case slug = "slug"
		case title = "title"
		case description = "description"
		case publishedAt = "published_at"
		case updatedAt = "updated_at"
		case startsAt = "starts_at"
		case endsAt = "ends_at"
		case onlySubmissionsAfter = "only_submissions_after"
		case featured = "featured"
		case totalPhotos = "total_photos"
		case currentUserContributions = "current_user_contributions"
		case totalCurrentUserSubmissions = "total_current_user_submissions"
		case links = "links"
		case status = "status"
		case owners = "owners"
		case coverPhoto = "cover_photo"
		case previewPhotos = "preview_photos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(String.self, forKey: .id)
		slug = try values.decode(String.self, forKey: .slug)
		title = try values.decode(String.self, forKey: .title)
		description = try values.decode(String.self, forKey: .description)
		publishedAt = try values.decode(String.self, forKey: .publishedAt)
		updatedAt = try values.decode(String.self, forKey: .updatedAt)
		startsAt = try values.decode(String.self, forKey: .startsAt)
		endsAt = try values.decode(String.self, forKey: .endsAt)
		onlySubmissionsAfter = nil // TODO: Add code for decoding `onlySubmissionsAfter`, It was null at the time of model creation.
		featured = try values.decode(Bool.self, forKey: .featured)
		totalPhotos = try values.decode(Int.self, forKey: .totalPhotos)
		currentUserContributions = [] // TODO: Add code for decoding `currentUserContributions`, It was empty at the time of model creation.
		totalCurrentUserSubmissions = nil // TODO: Add code for decoding `totalCurrentUserSubmissions`, It was null at the time of model creation.
		links = try values.decode(Links.self, forKey: .links)
		status = try values.decode(String.self, forKey: .status)
		owners = try values.decode([Owners].self, forKey: .owners)
		coverPhoto = try values.decode(CoverPhoto.self, forKey: .coverPhoto)
		previewPhotos = try values.decode([PreviewPhotos].self, forKey: .previewPhotos)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(slug, forKey: .slug)
		try container.encode(title, forKey: .title)
		try container.encode(description, forKey: .description)
		try container.encode(publishedAt, forKey: .publishedAt)
		try container.encode(updatedAt, forKey: .updatedAt)
		try container.encode(startsAt, forKey: .startsAt)
		try container.encode(endsAt, forKey: .endsAt)
		// TODO: Add code for encoding `onlySubmissionsAfter`, It was null at the time of model creation.
		try container.encode(featured, forKey: .featured)
		try container.encode(totalPhotos, forKey: .totalPhotos)
		// TODO: Add code for encoding `currentUserContributions`, It was empty at the time of model creation.
		// TODO: Add code for encoding `totalCurrentUserSubmissions`, It was null at the time of model creation.
		try container.encode(links, forKey: .links)
		try container.encode(status, forKey: .status)
		try container.encode(owners, forKey: .owners)
		try container.encode(coverPhoto, forKey: .coverPhoto)
		try container.encode(previewPhotos, forKey: .previewPhotos)
	}

}
