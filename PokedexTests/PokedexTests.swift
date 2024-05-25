import XCTest
@testable import Pokedex

class PokedexTests: XCTestCase {
    
    var sut: PokemonViewModel!
    var mockService = MockService()

    override func setUp() async throws {
        try await super.setUp()
        sut = PokemonViewModel()
    }
    
    func testgetData() async {
        
        await sut.fetch()
        
    }

}


//XCTAssertEqual(pokemonResult.first?.name, "Bola")
