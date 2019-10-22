/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Person : Codable {
	let id : Int?
	let url : String?
	let name : String?
	let country : Country?
	let birthday : String?
	let deathday : String?
	let gender : String?
	let image : ImageCodable?
	let links : Links?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case url = "url"
		case name = "name"
		case country = "country"
		case birthday = "birthday"
		case deathday = "deathday"
		case gender = "gender"
		case image = "image"
		case links = "_links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
		birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
		deathday = try values.decodeIfPresent(String.self, forKey: .deathday)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		image = try values.decodeIfPresent(ImageCodable.self, forKey: .image)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
	}

}
