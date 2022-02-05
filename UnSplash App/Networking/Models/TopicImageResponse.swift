//
//  TopicImageResponse.swift
//  UnSplash App
//
//  Created by Girish Parate on 02/10/21.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topicImageResponse = try? newJSONDecoder().decode(TopicImageResponse.self, from: jsonData)

import Foundation

// MARK: - TopicImageResponseElement
struct TopicImageResponseElement: Codable {
    let id: String?
    let createdAt, updatedAt: Date?
    let promotedAt: Date?
    let width, height: Int?
    let color, blurHash, topicImageResponseDescription: String?
    let altDescription: String?
    //    let urls: Urls?
    let links: TopicImageResponseLinks?
    let categories: [String]?
    let likes: Int?
    let likedByUser: Bool?
    //    let currentUserCollections: [JSONAny]?
    //    let sponsorship: JSONNull?
    //    let topicSubmissions: TopicSubmissions?
    //    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case topicImageResponseDescription = "description"
        case altDescription = "alt_description"
        case links, categories, likes //urls
        case likedByUser = "liked_by_user"
        //        case currentUserCollections = "current_user_collections"
        //        case sponsorship
        //        case topicSubmissions = "topic_submissions"
        //        case user
    }
}

// MARK: - TopicImageResponseLinks
struct TopicImageResponseLinks: Codable {
    let linksSelf, html, download, downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - TopicSubmissions
//struct TopicSubmissions: Codable {
//    let the3DRenders, fashion: The3_DRenders?
//
//    enum CodingKeys: String, CodingKey {
//        case the3DRenders = "3d-renders"
//        case fashion
//    }
//}

// MARK: - The3_DRenders
struct The3_DRenders: Codable {
    let status: Status?
    let approvedOn: Date?
    
    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

enum Status: String, Codable {
    case approved = "approved"
}




enum Bio: String, Codable {
    case a3DBeginnerABlenderUser = "A 3D beginner.\u{d}\nA blender user."
    case iM17YearsOldAndIDo3DRenders = "I'm 17 years old and I do 3D renders"
}

enum FirstName: String, Codable {
    case cash = "Cash"
    case simon = "SIMON"
}

enum ID: String, Codable {
    case vZkDtZpmq6C = "vZkDtZpmq6c"
    case xk10OSrKDyI = "XK10OSrKDyI"
}

enum InstagramUsername: String, Codable {
    case graphicsCash = "graphics_cash"
    case simonppt2 = "simonppt2"
}

enum LastName: String, Codable {
    case lee = "LEE"
    case macanaya = "Macanaya"
}


enum Name: String, Codable {
    case cashMacanaya = "Cash Macanaya"
    case simonLee = "SIMON LEE"
}

//// MARK: - ProfileImage
//struct ProfileImage: Codable {
//    let small, medium, large: String?
//}

// MARK: - Social
//struct Social: Codable {
//    let instagramUsername: InstagramUsername?
//    let portfolioURL: String?
//    let twitterUsername: String?
//    let paypalEmail: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case instagramUsername = "instagram_username"
//        case portfolioURL = "portfolio_url"
//        case twitterUsername = "twitter_username"
//        case paypalEmail = "paypal_email"
//    }
//}

enum Username: String, Codable {
    case cashmacanaya = "cashmacanaya"
    case simonppt = "simonppt"
}



