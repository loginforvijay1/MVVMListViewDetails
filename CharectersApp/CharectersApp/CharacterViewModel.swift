//
//  CharecterViewModel.swift
//  CharectersApp
//
//  Created by Vijay Reddy on 20/07/24.
//

import Foundation
import Combine

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var charecters:[Character] = []
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    
    private let respository: RespositoryProtocol
    
    init(respository: RespositoryProtocol = Respository()) {
        self.respository = respository
    }
    
    func fetchCharecters() {
        Task {
            do {
                charecters = try await respository.fetchCharecters()
            } catch {
                showAlert.toggle()
                errorMessage = "Failed to Load charecters: \(error)"
            }
        }
        
    }
}
