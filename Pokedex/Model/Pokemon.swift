import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String?
    let imageUrl: String?
    let height: Int?
    let weight: Int?
    let abilities: [Ability]?
    let baseExperience: Int?
    let moves: [Move]?
    let sprites: Sprites?
    let types: [Types]?
    let stats: [Stats]?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        self.abilities = try container.decodeIfPresent([Ability].self, forKey: .abilities)
        self.baseExperience = try container.decodeIfPresent(Int.self, forKey: .baseExperience)
        self.moves = try container.decodeIfPresent([Move].self, forKey: .moves)
        self.sprites = try container.decodeIfPresent(Sprites.self, forKey: .sprites)
        self.types = try container.decodeIfPresent([Types].self, forKey: .types)
        self.stats = try container.decodeIfPresent([Stats].self, forKey: .stats)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case imageUrl
        case height
        case weight
        case abilities
        case baseExperience
        case moves
        case sprites
        case types
        case stats
    }

}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - Move
struct Move: Codable {
    let move: Species
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - Sprit
struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Type
struct Types: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

// MARK: - Stats
struct Stats: Codable {
    let stat: Stat
    let baseStat: Int
    
    enum CodingKeys: String, CodingKey {
        case stat
        case baseStat = "base_stat"
    }
}

struct Stat: Codable {
    let name: String
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: Species

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}
