import SwiftUI

struct PokedexView: View {
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject var viewModel = PokemonViewModel()
    @ObservedObject var favoritePokemons = FavoritePokemon()
    
    @State private var searchText: String = ""
    @State public var trainer = "Fulvio"
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                LazyVGrid(columns: gridItems, spacing: 16) {
                    
                    ForEach(filteredPokemons, id: \.name ) { pokemon in
                        
                        PokemonCard(viewModel: viewModel, url: pokemon.url )

                    }
                    
                }
                .padding(.horizontal)
                
            }
            
            .overlay(alignment: .center, content: {
                
                if viewModel.isLoading {
                    ProgressView()
                        .controlSize(.large)
                }
                
                if filteredPokemons.isEmpty && !viewModel.isLoading {
                    Text("No Pokemons")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                
            })
            
            .task{
                await viewModel.fetch()
            }
            
            .searchable(text: $searchText)
            
            .navigationTitle("\(trainer)'s Pokedex")
            
            .navigationBarItems(leading: NavigationLink(
                destination: FavoriteListView(favoritePokemons: favoritePokemons, viewModel: viewModel),
                label: { Image("pokeball")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                }), trailing: NavigationLink(
                    destination: TrainerView(trainer: $trainer),
                    label: { Image("user")
                            .resizable()
                            .frame(width: 32, height: 32)
                    })
            )
        }
    }
    
    var filteredPokemons: [PokemonEntry] {
        return searchText.isEmpty ? viewModel.pokemons : viewModel.pokemons.filter {
            $0.name.contains(searchText.lowercased()) == true
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
