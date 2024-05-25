
import Foundation

class MockService {
    
    private var data: Data
    
    init() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "json")
        let url = URL(fileURLWithPath: path ?? "")
        self.data = try! Data(contentsOf: url)
    }
    
    func getData(completion: @escaping ([PokemonEntry]) -> ()) {
        let data = try! JSONDecoder().decode(PokemonList.self, from: self.data)
        completion(data.results)
    }
    
    func fetchSelectedPokemon(stringUrl: String, completion: @escaping (Pokemon?) -> ()) {
        
    }
}
