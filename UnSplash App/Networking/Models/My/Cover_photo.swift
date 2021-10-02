/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Cover_photo : Codable {
	let id : String?
	let created_at : String?
	let updated_at : String?
	let promoted_at : String?
	let width : Int?
	let height : Int?
	let color : String?
	let blur_hash : String?
	let description : String?
	let alt_description : String?
	let urls : Urls?
	let links : Links?
	let categories : [String]?
	let likes : Int?
	let liked_by_user : Bool?
	let current_user_collections : [String]?
	let sponsorship : String?
	let topic_submissions : Topic_submissions?
	let user : User?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case promoted_at = "promoted_at"
		case width = "width"
		case height = "height"
		case color = "color"
		case blur_hash = "blur_hash"
		case description = "description"
		case alt_description = "alt_description"
		case urls = "urls"
		case links = "links"
		case categories = "categories"
		case likes = "likes"
		case liked_by_user = "liked_by_user"
		case current_user_collections = "current_user_collections"
		case sponsorship = "sponsorship"
		case topic_submissions = "topic_submissions"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		promoted_at = try values.decodeIfPresent(String.self, forKey: .promoted_at)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		blur_hash = try values.decodeIfPresent(String.self, forKey: .blur_hash)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		alt_description = try values.decodeIfPresent(String.self, forKey: .alt_description)
		urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
		categories = try values.decodeIfPresent([String].self, forKey: .categories)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user)
		current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
		sponsorship = try values.decodeIfPresent(String.self, forKey: .sponsorship)
		topic_submissions = try values.decodeIfPresent(Topic_submissions.self, forKey: .topic_submissions)
		user = try values.decodeIfPresent(User.self, forKey: .user)
	}

}