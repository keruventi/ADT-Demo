//
//  ContentView.swift
//  ADT-Demo
//
//  Created by Karnakar Eruventi on 6/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = EpisodeViewModel()
    
    var body: some View {
        NavigationView {
            List(vm.episodes) { episode in
                NavigationLink(destination: EpisodeDetailsView(url: episode.url)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(episode.name ?? "No Name")
                        Text(episode.episode ?? "")
                        Text(episode.air_date ?? "")
                    }
                }.onAppear() {
                    if vm.episodes.last?.id == episode.id, let url = vm.info?.next {
                        DispatchQueue.main.async {
                            vm.fetchAllEpisodes(url: url)
                        }
                    }
                }
                
            }.task {
                vm.fetchAllEpisodes()
            }.navigationTitle("Episodes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
