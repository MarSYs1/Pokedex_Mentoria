import SwiftUI
import Kingfisher

struct FavoriteListView: View {
    @ObservedObject var favoritePokemons: FavoritePokemon
    var viewModel: PokemonViewModel
    
    var body: some View {
        if (favoritePokemons.myList.count == 0) {
            VStack(alignment: .center) {
                Text("You haven't added any Pokemon into your favorite list")
                    .padding()
                    .multilineTextAlignment(.center)
                    .offset(y: -50)
            }
        }
        else {
            NavigationView {
                List {
                    ForEach(favoritePokemons.myList) { pokemon in
                        NavigationLink(
//                            PokemonView(pokemon: pokemon, pokemonViewModel: viewModel, favoritePokemons: favoritePokemons)
                            destination: EmptyView(),
                            label: {
                                HStack {
                                    Text("#\(pokemon.id)")
                                    
                                    Text(pokemon.name?.capitalized ?? "")
                                    
                                    Spacer()
                                    
                                    KFImage(URL(string: pokemon.imageUrl ?? ""))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                }
                            }
                        )
                    }
                    .onDelete(perform: delete)
                }
                .navigationTitle("Favorite Pokemons")
                .navigationBarTitleDisplayMode(.inline)
            }
            Text("\(favoritePokemons.myList.count)/6 pokemons")
                .padding(.vertical, 10)
        }
    }
    
    // ACKNOWLEDGED BUG: Deleting the last pokemon form the FavoriteViewList will crash the program
    func delete(at offsets: IndexSet) {
        if favoritePokemons.myList.count > 0 {
            favoritePokemons.myList.remove(atOffsets: offsets)
        } else {
            return
        }
    }
}
