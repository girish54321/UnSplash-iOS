/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Json4Swift_Base : Codable {
	let id : String?
	let slug : String?
	let title : String?
	let description : String?
	let published_at : String?
	let updated_at : String?
	let starts_at : String?
	let ends_at : String?
	let only_submissions_after : String?
	let featured : Bool?
	let total_photos : Int?
	let current_user_contributions : [String]?
	let total_current_user_submissions : String?
	let links : Links?
	let status : String?
	let owners : [Owners]?
	let cover_photo : Cover_photo?
	let preview_photos : [Preview_photos]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case slug = "slug"
		case title = "title"
		case description = "description"
		case published_at = "published_at"
		case updated_at = "updated_at"
		case starts_at = "starts_at"
		case ends_at = "ends_at"
		case only_submissions_after = "only_submissions_after"
		case featured = "featured"
		case total_photos = "total_photos"
		case current_user_contributions = "current_user_contributions"
		case total_current_user_submissions = "total_current_user_submissions"
		case links = "links"
		case status = "status"
		case owners = "owners"
		case cover_photo = "cover_photo"
		case preview_photos = "preview_photos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		starts_at = try values.decodeIfPresent(String.self, forKey: .starts_at)
		ends_at = try values.decodeIfPresent(String.self, forKey: .ends_at)
		only_submissions_after = try values.decodeIfPresent(String.self, forKey: .only_submissions_after)
		featured = try values.decodeIfPresent(Bool.self, forKey: .featured)
		total_photos = try values.decodeIfPresent(Int.self, forKey: .total_photos)
		current_user_contributions = try values.decodeIfPresent([String].self, forKey: .current_user_contributions)
		total_current_user_submissions = try values.decodeIfPresent(String.self, forKey: .total_current_user_submissions)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		owners = try values.decodeIfPresent([Owners].self, forKey: .owners)
		cover_photo = try values.decodeIfPresent(Cover_photo.self, forKey: .cover_photo)
		preview_photos = try values.decodeIfPresent([Preview_photos].self, forKey: .preview_photos)
	}

}