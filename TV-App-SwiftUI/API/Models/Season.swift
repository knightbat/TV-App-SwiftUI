/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Season : Codable, Identifiable {
	let id : Int?
	let url : String?
	let number : Int?
	let name : String?
	let episodeOrder : Int?
	let premiereDate : String?
	let endDate : String?
	let network : Network?
	let webChannel : String?
	let image : ImageCodable?
	let summary : String?
	let links : Links?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case url = "url"
		case number = "number"
		case name = "name"
		case episodeOrder = "episodeOrder"
		case premiereDate = "premiereDate"
		case endDate = "endDate"
		case network = "network"
		case webChannel = "webChannel"
		case image = "image"
		case summary = "summary"
		case links = "_links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		number = try values.decodeIfPresent(Int.self, forKey: .number)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		episodeOrder = try values.decodeIfPresent(Int.self, forKey: .episodeOrder)
		premiereDate = try values.decodeIfPresent(String.self, forKey: .premiereDate)
		endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
		network = try values.decodeIfPresent(Network.self, forKey: .network)
		webChannel = try values.decodeIfPresent(String.self, forKey: .webChannel)
		image = try values.decodeIfPresent(ImageCodable.self, forKey: .image)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
	}

}
