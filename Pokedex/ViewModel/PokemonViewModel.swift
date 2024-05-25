import SwiftUI
import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    
    @Published var pokemons = [PokemonEntry]()
    @Published var isLoading = true
    
    private var serviceManager = Service()
    private var cancellable: AnyCancellable?
    
    //MARK: FETCH POKEMON`S
    final public func fetch() async {
        
        await serviceManager.GET(from: "https://pokeapi.co/api/v2/pokemon?limit=151", completionHandler: { result in
            
            guard let getData = try? result.get() else { return }
            
            if let data = try? JSONDecoder().decode(PokemonList.self, from: getData ) {
                
                DispatchQueue.main.async {
                    self.pokemons.append(contentsOf: data.results)
                    self.isLoading = false
                }
                
            }
        })
        
    }
    
    //MARK: - GET DATA POKEMON
    final public func getPokemon(from url: String, completionHandler: @escaping (Result<Pokemon, Never>) -> Void) async {
                
        await serviceManager.GET(from: url ) { result in
            
            guard let data = try? result.get() else { return }
            
            if let pokemonData = try? JSONDecoder().decode(Pokemon.self, from: data) {
                
                completionHandler(.success(pokemonData))
                
            }
            
        }
        
    }
    
    //MARK: - GET IMAGE POKEMIN
    final public func getImagePokemon() async {
        
    }
    
    final public func addFavo(){
        
    }
    
    public func getBackgroundColor(forType type: String) -> UIColor {
        switch type {
        case "fire":
            return .systemRed
        case "poison":
            return .systemBrown
        case "grass":
            return .systemGreen
        case "water":
            return .systemCyan
        case "psychic":
            return .systemPurple
        case "normal":
            return .systemOrange
        case "ground":
            return .systemGray
        case "flying":
            return .systemTeal
        case "fairy":
            return .systemPink
        case "bug":
            return .systemGray2
        case "electric":
            return .systemYellow
        case "rock":
            return .systemGray
        case "fighting":
            return .systemRed
        default:
            return .systemIndigo
        }
    }
}

extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataString = String(data: self, encoding: .utf8)
        let parsedDataString = dataString?.replacingOccurrences(of: string, with: "").replacingOccurrences(of: "\n", with: " ")
        guard let data = parsedDataString?.data(using: String.Encoding.utf8) else { return nil }
        return data
    }
}

extension PokemonViewModel {

    
    
//    func getData(completion: @escaping ([PokemonEntry]) -> ()) {
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            
//            let pokemonList = try! JSONDecoder().decode(PokemonList.self, from: data)
//            
//            DispatchQueue.main.async {
//                completion(pokemonList.results)
//            }
//            
//        }.resume()
//    }
//    
//    
//    func fetchSelectedPokemon(stringUrl: String, completion: @escaping (Pokemon?) -> ()) {
//        guard let url = URL(string: stringUrl) else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            
//            let pokemon = try! JSONDecoder().decode(Pokemon.self, from: data)
//            
//            DispatchQueue.main.async {
//                completion(pokemon)
//            }
//            
//        }.resume()
//    }
}
