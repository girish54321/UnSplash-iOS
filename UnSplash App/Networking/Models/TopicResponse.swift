
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topicResponse = try? newJSONDecoder().decode(TopicResponse.self, from: jsonData)

import Foundation

// MARK: - TopicResponseElement
struct TopicResponseElement: Decodable {
    let id, slug, title, topicResponseDescription: String?
    let updatedAt, startsAt: String?
    let endsAt: String?
    let onlySubmissionsAfter: String?
    let featured: Bool?
    let totalPhotos: Int?
    //    let currentUserContributions: [String]?
    //    let totalCurrentUserSubmissions: String?
    //    let links: TopicResponseLinks?
    let status: TopicResponseStatus?
    //    let owners: [User]?
    let coverPhoto: CoverPhoto?
    //    let previewPhotos: [PreviewPhoto]?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, title
        case topicResponseDescription = "description"
        //        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case onlySubmissionsAfter = "only_submissions_after"
        case featured = "featured"
        case totalPhotos = "total_photos"
        //        case currentUserContributions = "current_user_contributions"
        //        case totalCurrentUserSubmissions = "total_current_user_submissions"
        //        case links, status, owners
        case status
        case coverPhoto = "cover_photo"
        //        case previewPhotos = "preview_photos"
    }
}

// MARK: - CoverPhoto
struct CoverPhoto: Decodable {
    let id: String?
    let createdAt, updatedAt, promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let coverPhotoDescription: String?
    let altDescription: String?
    let urls: Urls?
    let links: CoverPhotoLinks?
    //    let categories: [String]?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let sponsorship: String?
    //    let topicSubmissions: [String: TopicSubmission]?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case coverPhotoDescription = "description"
        case altDescription = "alt_description"
        case urls, links ,likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship = "sponsorship"
        //        case topicSubmissions = "topic_submissions"
        case user
    }
}

// MARK: - CoverPhotoLinks
struct CoverPhotoLinks: Decodable {
    let linksSelf, html, download, downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - TopicSubmission
struct TopicSubmission: Decodable {
    let status: TopicSubmissionStatus?
    let approvedOn: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

enum TopicSubmissionStatus: String, Decodable {
    case approved = "approved"
}

// MARK: - TopicResponseLinks
struct TopicResponseLinks: Decodable {
    let linksSelf, html, photos: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos
    }
}

// MARK: - PreviewPhoto
struct PreviewPhoto: Decodable {
    let id: String?
    let createdAt, updatedAt: Date?
    let blurHash: String?
    let urls: Urls?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case urls
    }
}

enum TopicResponseStatus: String, Codable {
    case statusOpen = "open"
}

//typealias TopicResponse = [TopicResponseElement]

