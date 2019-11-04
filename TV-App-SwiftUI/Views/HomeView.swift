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
    
    @ObservedObject var seriesStore  = APIStore(with: .listSeries)
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView() {
            List(self.seriesStore.serieses) { series in
                SeriesCell(series : series)
            }
            .navigationBarTitle("Shows", displayMode: .inline)
        }
    }
}


struct SeriesCell: View {
    
    var series: Series
    
    var body: some View {
        NavigationLink(destination: DetailsView(series: series)) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .center) {
                    WebImage(url: URL(string: (series.image?.medium ?? "")))
                        .placeholder{Image(systemName: "camera")}
                        .indicator(.activity)
                        .animation(.easeInOut(duration: 0.5))
                        .transition(.fade)
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width - 60, maxHeight: .infinity, alignment: .center)
                        .padding(5)
                    
                    Text(String(series.name ?? ""))
                        .bold()
                        .font(.largeTitle)
                        .padding(1)
                    
                    Text(String(removeTags(from: series.summary)))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(5)
                    
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
                }
            }
            .background(Color.white)
            .cornerRadius(6)
            .shadow(radius: 5)
        }
    }
}

func removeTags(from string: String?) -> String {
    let str = string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    return str ?? ""
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let content = HomeView()
        content.seriesStore.serieses = SampleAPIResult.getDummySeries()
        return content
            .previewDevice("iPhone 7")
    }
}
