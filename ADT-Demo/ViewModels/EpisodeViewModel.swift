//
//  EpisodeViewModel.swift
//  ADT-Demo
//
//  Created by Karnakar Eruventi on 6/1/23.
//

import Foundation

class EpisodeViewModel: ObservableObject {
    @Published var episodes = [EpisodeResult]()
    @Published var singleEpisode: EpisodeResult?
    @Published var info: EpisodeInfo?
    
    func fetchAllEpisodes(url: String? = nil) {
        //Make call to network instance
        NetworkService.shared.fetchData(type: Episode.self, urlString: url) { result in
            switch result {
            case .success(let episode):
                self.episodes.append(contentsOf: episode.results)
                self.info = episode.info
            case .failure(let error):
                print("FAILED...", error)
            }
        }
    }
    
    func fetchSingleEpisode(url: String) {
        NetworkService.shared.fetchData(type: EpisodeResult.self, urlString: url) { result in
            switch result {
            case .success(let episode):
                self.singleEpisode = episode
            case .failure(let error):
                print("FAILED...", error)
            }
        }
    }
}
