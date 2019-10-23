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
    @ObservedObject var seasonStore: APIStore
    @ObservedObject var castStore: APIStore
    @State var isCast: Bool = true

    
    init(series: Series) {
        self.series = series
        seasonStore = APIStore(with: series.id ?? 0, type: .listseasons)
        castStore = APIStore(with: series.id ?? 0, type: .listCast)
    }
    
    var body: some View {
        
        ZStack {
            ImageView(image: series.image?.original ?? "")
                .blur(radius: 30)
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            VStack {
                ScrollView {
                    VStack {
                        
                        ImageView(image: series.image?.original ?? "")
                            .frame(width: 350, height: 350, alignment: .center)
                        
                        DetailsInfoView(series: series)
                        
                        SeasonListView(seasons: seasonStore.seasons, seriesID: self.series.id ?? 0)
                        
                        CastCrewView(isCast: $isCast)
                        
                        CastCrewListView(cast: castStore.casts)

                    }
                }
                .background(Color.clear)
            }
            .navigationBarTitle(series.name ?? "")
        }
    }
}



struct DetailsInfoView: View {
    
    let series: Series
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
    }
    
}


struct ImageView: View {
     var image: String
     var body: some View {
         WebImage(url: URL(string: image), placeholder: Image(systemName: "camera"))
             .resizable()
             .scaledToFit()
             .padding(5)
     }
 }

struct CastCrewView: View {
    
    @Binding var isCast: Bool
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                Button(action: {
                    self.isCast = true
                }) {
                    Text("Cast")
                }
                .frame(height: 40)
                Spacer()
            }
            .background(isCast ? Color.white : Color.clear)
            .cornerRadius(6)
            .foregroundColor(isCast ? Color.black : Color.white)
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.isCast = false
                }) {
                    Text("Crew")
                }
                .frame(height: 40)
                Spacer()
            }
            .background(!isCast ? Color.white : Color.clear)
            .cornerRadius(6)
            .foregroundColor(!isCast ? Color.black : Color.white)
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
                            .cornerRadius(70/2)
                            .foregroundColor(Color.white)
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
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(50)
    }
}


struct CastCrewListView: View {
    
    var cast: [CastCrew]
    var body: some View {
        VStack {
            ForEach(cast) { cast in
                HStack{
                    IconImageView(image: cast.person?.image?.medium ?? "")
                        .padding([.leading], 5)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(cast.person?.name ?? "")
                            .font(.headline)
                        Text(cast.character?.name ?? "")
                            .font(.subheadline)
                    }
                    .padding([.leading], 5)
                    Spacer()
                    IconImageView(image: cast.character?.image?.medium ?? "")
                        .padding([.trailing], 5)
                }
                .background(Color.white.opacity(0.8))
                .cornerRadius(6)
            }
        }
        .padding(20)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let series = SampleAPIResult.getDummySeries()[3]
        var view = DetailsView(series: series)
        view.seasonStore =  APIStore()
        view.castStore = APIStore()
        view.seasonStore.seasons = SampleAPIResult.getDummySeasons()
        view.castStore.casts = SampleAPIResult.getDummyCasts()
        
//        let cell = CastCrewListView(cast: SampleAPIResult.getDummyCasts())
        
        return view
    }
}




