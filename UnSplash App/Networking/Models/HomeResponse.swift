// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeResponse = try? newJSONDecoder().decode(HomeResponse.self, from: jsonData)

import Foundation

// MARK: - HomeResponseElement
struct HomeResponseElement :Decodable {
    let id: String?
    let createdAt, updatedAt: Date?
    let promotedAt: Date?
    let width, height: Int?
    let color, blurHash: String?
    let homeResponseDescription, altDescription: String?
    let urls: Urls?
    let links: HomeResponseLinks?
    let categories: [String]?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let sponsorship: Sponsorship?
    let topicSubmissions: TopicSubmissions?
    let user: User?
}

// MARK: - HomeResponseLinks
struct HomeResponseLinks :Decodable {
    let linksSelf, html, download, downloadLocation: String?
}

// MARK: - Sponsorship
struct Sponsorship :Decodable {
    let impressionUrls: [String]?
    let tagline: String?
    let taglineURL: String?
    let sponsor: User?
}

// MARK: - User
struct User :Decodable {
    let id: String?
    let updatedAt: Date?
    let username, name, firstName: String?
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio: String?
    let location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int?
    let acceptedTos, forHire: Bool?
    let social: Social?
}

// MARK: - UserLinks
struct UserLinks :Decodable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?
}

// MARK: - ProfileImage
struct ProfileImage :Decodable {
    let small, medium, large: String?
}

// MARK: - Social
struct Social :Decodable {
    let instagramUsername: String?
    let portfolioURL: String?
    let twitterUsername: String?
    let paypalEmail: String?
}

// MARK: - TopicSubmissions
struct TopicSubmissions :Decodable {
    let foodDrink, businessWork, technology: BusinessWork?
}

// MARK: - BusinessWork
struct BusinessWork :Decodable {
    let status: String?
    let approvedOn: Date?
}

// MARK: - Urls
struct Urls :Decodable {
    let raw, full, regular, small: String?
    let thumb: String?
}
