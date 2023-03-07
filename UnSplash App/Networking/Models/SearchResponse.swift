// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topicImageResponse = try? newJSONDecoder().decode(TopicImageResponse.self, from: jsonData)

import Foundation

// MARK: - TopicImageResponse
struct SearchImageResponse : Decodable{
    var total, totalPages: Int?
    var results: [Result]?
}

// MARK: - Result
struct Result : Decodable {
    var id: String?
    var createdAt, updatedAt: Date?
    var promotedAt: Date?
    var width, height: Int?
    var color, blur_hash, resultDescription, altDescription: String?
    var urls: Urls?
    var links: ResultLinks?
//    var categories: [String]
    var likes: Int?
    var likedByUser: Bool?
    var currentUserCollections:  [String?]?
//    var sponsorship: 
    var topicSubmissions: ResultTopicSubmissions?
    var user: User?
    var tags: [Tag]?
}

// MARK: - ResultLinks
struct ResultLinks : Decodable{
    var linksSelf, html, download, downloadLocation: String?
}

// MARK: - Tag
struct Tag : Decodable{
    var type, title: String?
    var source: Source?
}

// MARK: - Source
struct Source : Decodable{
    var ancestry: Ancestry?
    var title, subtitle, sourceDescription, metaTitle: String?
    var metaDescription: String?
    var coverPhoto: CoverPhoto?
}

// MARK: - Ancestry
struct Ancestry : Decodable{
    var type, category, subcategory: Category?
}

// MARK: - Category
struct Category : Decodable{
    var slug, prettySlug: String?
}


// MARK: - CoverPhotoTopicSubmissions
struct CoverPhotoTopicSubmissions : Decodable{
    var texturesPatterns: Fashion?
}

// MARK: - Fashion
struct Fashion : Decodable{
    var status: String?
    var approvedOn: Date?
}


// MARK: - ResultTopicSubmissions
struct ResultTopicSubmissions : Decodable{
    var nature: Nature?
    var fashion: Fashion?
}

// MARK: - Nature
struct Nature : Decodable{
    var status: String?
}
