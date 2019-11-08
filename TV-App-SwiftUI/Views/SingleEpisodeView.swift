//
//  SingleEpisodeView.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 08/11/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import SwiftUI

struct SingleEpisodeView: View {
    
    var episode: Episode
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack{
            
            ImageView(image: episode.image?.original ?? "")
                .blur(radius: 30)
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack{
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .foregroundColor(Color.white)
                    }
                    
                    Text("S\(episode.airedSeason ?? 0) E\(episode.episodeNumber ?? 0): \(episode.episodeName ?? "")")
                        .font(.title)
                    ImageView(image: episode.image?.original ?? "")
                    HStack {
                        Text("Run time:")
                            .bold()
                        Text("\(episode.runtime ?? 0) hrs")
                    }
                    HStack(alignment: .top) {
                        Text("Summary:")
                            .bold()
                        Text(removeTags(from: episode.summary ?? ""))
                    }
                    .padding(.bottom, 20)
                }
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(6)
            }
        }
    }
}

struct SingleEpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episode = SampleAPIResult.getDummyEpisodes().first
        return SingleEpisodeView(episode: episode!)
    }
}
