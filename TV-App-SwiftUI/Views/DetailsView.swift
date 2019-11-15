//
//  DetailsView.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 21/10/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    let series : Series
    @ObservedObject var apiStore = APIStore()
    @State private var isCast: Bool = true
    
    
    init(series: Series) {
        self.series = series
    }
    
    var body: some View {
        
        ZStack {
            ImageView(image: series.image?.original ?? "")
                .blur(radius: 30)
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack {
                        
                        ImageView(image: series.image?.original ?? "")
                            .frame(width: 350, height: 350, alignment: .center)
                        DetailsInfoView(series: series)
                        SeasonListView(seasons: apiStore.seasons, seriesID: self.series.id ?? 0)
                        CastCrewView(isCast: $isCast)
                        CastCrewListView(casts: apiStore.casts, crews: apiStore.crews, isCast: $isCast)
                        
                    }
                }
                .background(Color.clear)
            }
            .onAppear(perform: {
                
                self.apiStore.fetchSeason(with: self.series.id ?? 0)
                self.apiStore.fetchCasts(with: self.series.id ?? 0)
                self.apiStore.fetchCrews(with: self.series.id ?? 0)
                
            })
                .navigationBarTitle(series.name ?? "")
        }
        
    }
}



struct DetailsInfoView: View {
    
    let series: Series
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(alignment: .top) {
                Text("Summary:")
                Text(String(removeTags(from: series.summary)))
            }
            HStack {
                Text("Status :")
                Text(series.status ?? "")
            }
            HStack {
                Text("Premiered :")
                Text(series.premiered ?? "")
            }
            HStack {
                Text("Run time :")
                Text(String(series.runtime ?? 0))
            }
            HStack(alignment: .top) {
                Text("Official site :")
                Text(series.officialSite ?? "")
            }
            HStack(alignment: .top) {
                Text("URL :")
                Text(series.seriesURL ?? "")
            }
            HStack {
                Text("Rating :")
                Text(String(series.rating?.average ?? 0.0))
            }
        }
        .padding(10)
        .background(Color.white.opacity(0.5))
        .cornerRadius(5.0)
    }
    
}


struct ImageView: View {
    var image: String
    var body: some View {
        WebImage(url: URL(string: image))
            .placeholder{Image(systemName: "camera")}
            .resizable()
            .indicator(.activity)
            .scaledToFit()
            .padding(5)
    }
}

struct CastCrewView: View {
    
    @Binding var isCast: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                self.isCast = true
            }) {
                HStack {
                    Spacer()
                    Text("Cast")
                        .frame(height: 40)
                    Spacer()
                }
                .background(isCast ? Color.white : Color.clear)
                .cornerRadius(6)
                .foregroundColor(isCast ? Color.black : Color.white)
            }
            Button(action: {
                self.isCast = false
            }) {
                HStack {
                    Spacer()
                    Text("Crew")
                        .frame(height: 40)
                    Spacer()
                }
                .background(!isCast ? Color.white : Color.clear)
                .cornerRadius(6)
                .foregroundColor(!isCast ? Color.black : Color.white)
            }
        }
            
        .padding(.horizontal, 20)
    }
}

struct SeasonListView: View {
    
    var seasons: [Season]
    var seriesID: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(seasons) { season in
                    NavigationLink(destination: EpisodeView(seriesID: self.seriesID, seasonArray: self.seasons, selectedSeason: season.number ?? 0)){
                        Text(String(season.number ?? 0))
                            .font(.system(size: 35))
                            .frame(width: 70, height: 70, alignment: .center)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                            .clipShape(Circle())
                    }
                    
                }
            }
        }.padding(20)
    }
}

struct IconImageView: View {
    var image: String
    var body: some View {
        ImageView(image: image)
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100, alignment: .center)
            .clipShape(Circle())
    }
}


struct CastCrewListView: View {
    
    var casts: [CastCrew]
    var crews: [CastCrew]
    @Binding var isCast: Bool
    
    var body: some View {
        VStack {
            ForEach(isCast ? casts : crews) { cast in
                HStack{
                    IconImageView(image: cast.person?.image?.medium ?? "")
                        .padding([.top, .leading, .bottom], 5)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(cast.person?.name ?? "")
                            .font(.headline)
                        Text((self.isCast ? cast.character?.name : cast.type) ?? "")
                            .font(.subheadline)
                    }
                    .padding(.leading, 5)
                    Spacer()
                    if self.isCast {
                        IconImageView(image: cast.character?.image?.medium ?? "")
                            .padding([.trailing, .top, .bottom], 5)
                    }
                }
                .background(Color.white.opacity(0.8))
                .cornerRadius(6)
            }
        }
        .padding(20)
    }
}


func removeTags(from string: String?) -> String {
    let str = string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    return str ?? ""
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let series = SampleAPIResult.getDummySeries()[3]
        var view = DetailsView(series: series)
        view.apiStore =  APIStore()
        view.apiStore.seasons = SampleAPIResult.getDummySeasons()
        view.apiStore.casts = SampleAPIResult.getDummyCasts()
        view.apiStore.crews = SampleAPIResult.getDummyCrew()

//        let cell = CastCrewListView(cast: SampleAPIResult.getDummyCasts())
        
        return
            NavigationView {
                view
                    .navigationBarTitle("\(series.name ?? "")", displayMode: .inline)
        }
    }
}



