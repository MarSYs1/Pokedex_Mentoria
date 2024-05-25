import Foundation

struct PokemonList: Codable {
    var results: [PokemonEntry]
    
    init(results: [PokemonEntry]) {
        self.results = results
    }
    
    enum CodingKeys: CodingKey {
        case results
    }
    
}

struct PokemonEntry: Codable, Hashable {
    var name: String
    var url: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
    
}
