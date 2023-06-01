//
//  EpisodeDetailsView.swift
//  ADT-Demo
//
//  Created by Karnakar Eruventi on 6/1/23.
//

import SwiftUI

struct EpisodeDetailsView: View {
    @ObservedObject var vm = EpisodeViewModel()
    var url: String?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 5) {
                Text(vm.singleEpisode?.name ?? "No Title")
                Text(vm.singleEpisode?.episode ?? "")
                Text(vm.singleEpisode?.air_date ?? "")
            }.onAppear() {
                guard let url = url else { return }
                vm.fetchSingleEpisode(url: url)
            }
        }.navigationTitle("Episode Details")
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView()
    }
}
