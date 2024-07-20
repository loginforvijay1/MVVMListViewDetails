//
//  NetworkLayer.swift
//  CharectersApp
//
//  Created by Vijay Reddy on 20/07/24.
//

import Foundation

protocol ServiceLayerProtocol {
    func fetchCharecters() async throws -> [Character]
}

class ServiceLayer: ServiceLayerProtocol {
    let baseURL = "https://rickandmortyapi.com/api/"
    func fetchCharecters() async throws -> [Character] {
        
        guard let url = URL(string: "\(baseURL)character") else {
            throw NetworkErrors.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let respons = response as? HTTPURLResponse, (200...299).contains(respons.statusCode) else {
                throw NetworkErrors.fetchDataFails
            }
            let groups = try JSONDecoder().decode(Group.self, from: data)
            return groups.results
        } catch {
            throw NetworkErrors.decodingFailed
        }
    }
}

enum NetworkErrors: Error {
    case invalidURL
    case fetchDataFails
    case decodingFailed
}

struct Character: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}

struct Group: Codable {
    let results: [Character]
}
