/*
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Series : Identifiable, Codable {
    let id : Int?
	let seriesURL : String?
	let name : String?
	let type : String?
	let language : String?
	let status : String?
	let runtime : Int?
	let premiered : String?
	let officialSite : String?
	let rating : Rating?
	let weight : Int?
	let image : ImageCodable?
	let summary : String?
	let updated : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case seriesURL = "url"
		case name = "name"
		case type = "type"
		case language = "language"
        case status = "status"
		case runtime = "runtime"
		case premiered = "premiered"
		case officialSite = "officialSite"
		case rating = "rating"
		case weight = "weight"
		case image = "image"
		case summary = "summary"
		case updated = "updated"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		seriesURL = try values.decodeIfPresent(String.self, forKey: .seriesURL)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
		premiered = try values.decodeIfPresent(String.self, forKey: .premiered)
		officialSite = try values.decodeIfPresent(String.self, forKey: .officialSite)
		rating = try values.decodeIfPresent(Rating.self, forKey: .rating)
		weight = try values.decodeIfPresent(Int.self, forKey: .weight)
		image = try values.decodeIfPresent(ImageCodable.self, forKey: .image)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		updated = try values.decodeIfPresent(Int.self, forKey: .updated)
	}
}
