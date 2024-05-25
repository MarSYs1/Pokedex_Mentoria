import Foundation
import MapKit

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let cities = [
    City(name: "São Paulo", coordinate: CLLocationCoordinate2D(latitude: -23.533773, longitude: -46.625290)),
    City(name: "Minas Gerais", coordinate: CLLocationCoordinate2D(latitude: -19.841644, longitude: -43.986511)),
    City(name: "Rio de Janeiro", coordinate: CLLocationCoordinate2D(latitude: -22.908333, longitude: -43.196388)),
    City(name: "Brasilia", coordinate: CLLocationCoordinate2D(latitude: -15.793889, longitude: -47.882778)),
    City(name: "Salvador", coordinate: CLLocationCoordinate2D(latitude: -12.974722, longitude: -38.476665))
]
