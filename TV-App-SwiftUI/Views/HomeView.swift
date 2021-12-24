//
//  ContentView.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 17/10/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var apiStore  = APIStore()
    @State private var searchString = ""
    @State private var pageNumber = 1
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 5) {
                    ForEach(self.apiStore.serieses) { series in
                        SeriesCell(series : series)
                            .onAppear {
                                if series.id == self.apiStore.serieses.last?.id {
                                    self.pageNumber += 1
                                    self.apiStore.fetchSeries(pageNumber: self.pageNumber)
                                }
                            }
                    }
                }
            }
            
            .searchable(text: self.$searchString)
            .onChange(of: self.searchString, perform: { query in
                if query != "" {
                    self.apiStore.searchSeries(searchString:query)
                    self.pageNumber = 1
                } else if query == "" {
                    self.apiStore.fetchSeries(pageNumber: self.pageNumber)
                }
            })
            .navigationBarTitle("Shows", displayMode: .inline)
            .onAppear {
                self.searchString == "" ? self.apiStore.fetchSeries() : self.apiStore.searchSeries(searchString: self.searchString)
            }
            
        }
    }
}


struct SeriesCell: View {
    var series: Series
    var body: some View {
        NavigationLink(destination: DetailsView(series: series)) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: series.image?.original ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "camera")
                    }
                    .scaledToFit()
                    .frame(minWidth: UIScreen.main.bounds.width/2 - 5, minHeight:(UIScreen.main.bounds.width/2 - 5))
                    Text(String(series.name ?? ""))
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20))
                        .padding(5)
                        .foregroundColor(Color("titleColor"))
                }
                ZStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(Color.yellow)
                        .padding()
                    Text(String.localizedStringWithFormat("%.1f", series.rating?.average ?? 0))
                        .font(.system(size: 11))
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .background(Color.blue)
            .cornerRadius(6)
            .shadow(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let content = HomeView()
        content.apiStore.serieses = SampleAPIResult.getDummySeries()
        return content
            .previewDevice("iPhone 7")
    }
}
