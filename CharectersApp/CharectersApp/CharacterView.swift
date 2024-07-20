//
//  ContentView.swift
//  CharectersApp
//
//  Created by Vijay Reddy on 20/07/24.
//

import SwiftUI

struct CharacterView: View {
    
    @StateObject var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.charecters, id: \.id) { charecter in
                
                    NavigationLink(value: charecter) {
                        HStack(alignment: .top) {
                            AsyncImage(url: URL(string: charecter.image)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(charecter.name)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text(charecter.status)
                                    .font(.subheadline)
                            }
                    }
                }
               
            }
            .navigationTitle("Charecters")
            .navigationDestination(for: Character.self) { charecter in
                DetailsPage(charecter: charecter)
            }
            .onAppear {
                viewModel.fetchCharecters()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }

    }
}

struct DetailsPage : View {
    var charecter: Character
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: charecter.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width: 300, height: 300)
                .clipShape(Circle())
            
                .padding()
                Text(charecter.name)
                    .font(.headline)
                Text(charecter.species)
                    .font(.subheadline)
                Text(charecter.status)
                    .font(.subheadline)
        }.navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    CharacterView()
}
