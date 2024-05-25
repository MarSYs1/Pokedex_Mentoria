import SwiftUI
import Kingfisher

struct PokemonCard: View {
    
    @ObservedObject var viewModel: PokemonViewModel
    @State var url: String
    
    @State var pokemon: Pokemon?
    @State var backgroundColor: Color?
    
    init(viewModel: PokemonViewModel, url: String, pokemon: Pokemon? = nil, backgroundColor: Color? = nil) {
        self.viewModel = viewModel
        self.url = url
        self.pokemon = pokemon
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        
        NavigationLink(destination: PokemonView( pokemon: pokemon ), label: {
            
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(pokemon?.name?.capitalized ?? "")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                            .padding(.leading)
                        
                        Text(formattedId)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                            .padding(.leading, 2)
                    }
                    
                    HStack {
                        Text(pokemon?.types?.first?.type.name.capitalized ?? "")
                            .font(.subheadline).bold()
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.25))
                            )
                            .frame(width: 100, height: 24)
                        
                        KFImage(URL(string: pokemon?.sprites?.frontDefault ?? ""))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding([.bottom, .trailing], 8)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(color: backgroundColor ?? .white , radius: 4, x: 1.0, y: 1.0)
            
        })
        
        .task {
            await viewModel.getPokemon(from: url ) { result in
                
                if let pokemon = try? result.get() {
                    self.pokemon = pokemon
                    self.backgroundColor = Color(viewModel.getBackgroundColor(forType: pokemon.types?.first?.type.name ?? ""))
                }
                
            }
        }
        
    }
    
        var formattedId: String {
            let id = pokemon?.id ?? 0
            if id / 10 < 1 {
                return "#00\(id)"
            } else if id / 10 < 10 {
                return "#0\(id)"
            } else {
                return "#\(id)"
            }
        }
}
