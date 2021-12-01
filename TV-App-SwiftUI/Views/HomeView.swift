//
//  ContentView.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 17/10/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject var apiStore  = APIStore()
    @State private var searchString = ""
    @State private var pageNumber = 1
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView() {
            VStack {
                TextField("Search", text: $searchString, onEditingChanged: { status in
                    if !status && self.searchString != "" {
                        self.apiStore.searchSeries(searchString: self.searchString)
                        self.pageNumber = 1
                    } else if !status && self.searchString == "" {
                        self.apiStore.fetchSeries(pageNumber: self.pageNumber)
                    }
                })
                .padding(.all, 2.0)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
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
                .navigationBarTitle("Shows", displayMode: .inline)
                .onAppear {
                    self.searchString == "" ? self.apiStore.fetchSeries() : self.apiStore.searchSeries(searchString: self.searchString)
                }
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
                    WebImage(url: URL(string: (series.image?.original ?? "")))
                        .placeholder{Image(systemName: "camera")}
                        .resizable()
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
