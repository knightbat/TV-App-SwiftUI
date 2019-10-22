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
    
    @ObservedObject var seriesStore  = SeriesStore()
    
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
            VStack(alignment: .center) {
                WebImage(url: URL(string: (series.image?.medium ?? "")), placeholder: Image(systemName: "camera"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350, alignment: .center)
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
        content.seriesStore.serieses = ApiMapper().getDummySeries()
        return content
    }
}
