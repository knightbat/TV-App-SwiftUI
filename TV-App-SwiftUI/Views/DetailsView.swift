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
    @ObservedObject var seasonStore: SeasonStore
    
    
    init(series: Series) {
        self.series = series
        seasonStore = SeasonStore(with: series.id ?? 0)
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
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack() {
                                ForEach(seasonStore.seasons) { season in
                                    NavigationLink(destination: EpisodeView(seriesID: self.series.id ?? 0, seasonArray: self.seasonStore.seasons, selectedSeason: season.number ?? 0)){
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
 
 struct DetailsView_Previews: PreviewProvider {
     static var previews: some View {
         DetailsView(series: ApiMapper().getDummySeries()[3])
     }
 }
