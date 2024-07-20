//
//  Respository.swift
//  CharectersApp
//
//  Created by Vijay Reddy on 20/07/24.
//

import Foundation

protocol RespositoryProtocol {
    func fetchCharecters() async throws -> [Character]
}

class Respository: RespositoryProtocol  {

    private let networkLayer: ServiceLayerProtocol
    
    init(networkLayer: ServiceLayerProtocol = ServiceLayer()) {
        self.networkLayer = networkLayer
    }
    
    func fetchCharecters() async throws -> [Character] {
       return try await networkLayer.fetchCharecters()
    }
}
