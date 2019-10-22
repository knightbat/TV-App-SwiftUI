/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Episode : Codable, Identifiable {
	let id : Int?
	let episodeURL : String?
	let episodeName : String?
	let airedSeason : Int?
	let episodeNumber : Int?
	let airdate : String?
	let airtime : String?
	let airstamp : String?
	let runtime : Int?
	let image : ImageCodable?
	let summary : String?
	let links : Links?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case episodeURL = "url"
		case episodeName = "name"
		case airedSeason = "season"
		case episodeNumber = "number"
		case airdate = "airdate"
		case airtime = "airtime"
		case airstamp = "airstamp"
		case runtime = "runtime"
		case image = "image"
		case summary = "summary"
		case links = "_links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		episodeURL = try values.decodeIfPresent(String.self, forKey: .episodeURL)
		episodeName = try values.decodeIfPresent(String.self, forKey: .episodeName)
		airedSeason = try values.decodeIfPresent(Int.self, forKey: .airedSeason)
		episodeNumber = try values.decodeIfPresent(Int.self, forKey: .episodeNumber)
		airdate = try values.decodeIfPresent(String.self, forKey: .airdate)
		airtime = try values.decodeIfPresent(String.self, forKey: .airtime)
		airstamp = try values.decodeIfPresent(String.self, forKey: .airstamp)
		runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
		image = try values.decodeIfPresent(ImageCodable.self, forKey: .image)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
	}

}
