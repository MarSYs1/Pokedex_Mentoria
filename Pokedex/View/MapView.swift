import SwiftUI
import MapKit
import Kingfisher

let brazil = CLLocationCoordinate2D(latitude: -14.2350, longitude: -51.9253)

struct MapView: View {
    
    @State var pokemon: Pokemon
    
    @State private var region = MKCoordinateRegion(
        center: brazil,
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )
    
    @State var randomCities: [City] = [
        cities.randomElement()!,
        cities.randomElement()!,
        cities.randomElement()!,
        cities.randomElement()!,
        cities.randomElement()!,
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: randomCities) {
            MapAnnotation(coordinate: $0.coordinate) {
                KFImage(URL(string: pokemon.imageUrl ?? ""))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color(.white), lineWidth: 1))
                    .shadow(color: .red, radius: 4)
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        )
    }
}
