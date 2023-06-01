//
//  Episode.swift
//  ADT-Demo
//
//  Created by Karnakar Eruventi on 6/1/23.
//

import Foundation

struct Episode: Codable {
    let info: EpisodeInfo?
    let results: [EpisodeResult]
}

struct EpisodeInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct EpisodeResult: Codable, Identifiable {
    let id: Int?
    let name: String?
    let air_date: String?
    let episode: String?
    let characters: [String]?
    let url: String?
}
