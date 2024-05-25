import SwiftUI
import Kingfisher
import CoreLocation
import MapKit

struct PokemonView: View {
    
    @State var pokemon: Pokemon?
    @State var backgroundColor: Color?
    
    @State private var viewModel = PokemonViewModel()
    
    @State private var showDialogState = false
    @State private var isInFavoriteList = false
    @State private var angle = 0.0
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation
            .linear(duration: 4.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                MapView(pokemon: pokemon!)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 350)
                
                ZStack {
                    // simply remove this line for clean white background
                    LinearGradient(gradient: Gradient(colors: [self.backgroundColor ?? .white, Color.white]), startPoint: .top, endPoint: .center)
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        HStack {
                            Spacer()
                            
                            ZStack {
                                
                                Text(formattedId)
                                    .font(.headline).bold()
                                    .foregroundColor(.white)
                                    .offset(x: 150, y: -100)
                                
                                if (isInFavoriteList) {
                                    Image("spinningball")
                                        .resizable()
                                        .opacity(0.2)
                                        .frame(width: 230, height: 230)
                                        .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                                        .animation(self.foreverAnimation, value: self.isAnimating)
                                        .onAppear {
                                            self.isAnimating = true
                                        }
                                        .onDisappear {
                                            self.isAnimating = false
                                        }
                                        .padding(.top, 20)
                                } else {
                                    KFImage(URL(string: pokemon?.sprites?.frontDefault ?? ""))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding([.bottom, .trailing], 8)
                                }
                                
                                Button(action: {
                                    // disable alert when favorite list is full
//                                    if favoritePokemons.myList.count < 6 {
//                                        showDialogState = true
//                                    }
                                }) {
                                    KFImage(URL(string: pokemon?.imageUrl ?? ""))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                        .padding([.bottom, .trailing], 10)
                                        .padding(.top, 40)
                                }
                                .alert(dialogTitle, isPresented: $showDialogState) {
                                    if isInFavoriteList {
                                        Button("Remove from my favorite list") {
//                                            if let index = favoritePokemons.myList.firstIndex(where: { $0.name == pokemon.name }) {
//                                                favoritePokemons.myList.remove(at: index)
//                                                isInFavoriteList = false
//                                            }
                                        }
                                    } else {
                                        Button("Add to my favorite list") {
                                            // can only add max 6 pokemon
//                                            if favoritePokemons.myList.count < 6 && !isInFavoriteList {
//                                                favoritePokemons.myList.append(pokemon)
//                                                isInFavoriteList = true
//                                            }
                                        }
                                    }
                                    
                                    Button("Cancel", role: .cancel) {}
                                }
                            }
                            .padding(.top, 10)
                            
                            Spacer()
                        }
                        
                        VStack {
                            Text(pokemon?.name?.capitalized ?? "")
                                .font(.largeTitle)
                            
                            Text(pokemon?.types?.first?.type.name.capitalized ?? "")
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                                .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
                                .background(Color(viewModel.getBackgroundColor(forType: pokemon?.types?.first?.type.name ?? "")))
                                .cornerRadius(20)
                                .padding(.top, -12)
                            
                            StatsViews(pokemon: pokemon )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 50)
                    }
                }
                .background(.white)
                .cornerRadius(40)
                .padding(.top, -100)
                .zIndex(1)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .task {
            self.backgroundColor = Color(viewModel.getBackgroundColor(forType: pokemon?.types?.first?.type.name ?? ""))
        }
    }
    
    var dialogTitle: String {
        if !isInFavoriteList {
            return "I choose you \(pokemon?.name?.capitalized ?? "") !"
        } else {
            return "Goodbye \(pokemon?.name?.capitalized ?? "") :("
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

struct StatsViews: View {
    
   @State var pokemon: Pokemon?
    
    var body: some View {
        HStack {
            Text("Stats")
                .font(.system(size: 18, weight: .semibold))
                .padding(.bottom, 8)
            
            Spacer()
        }
        .padding(.top, 10)
        
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Height")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.bottom, 2)
                    
                    Text("\(heightToString)")
                        .bold()
                    
                }
                .padding(.vertical, 25)
                .padding(.leading, 20)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Weight")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.bottom, 2)
                    
                    Text("\(weightToString)")
                        .bold()
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 25)
            }
            .background(.white)
            .cornerRadius(16)
            .shadow(color: .gray, radius: 5, x: 0.0, y: 1.0)
            
            VStack(alignment: .leading) {
                BarChartView(pokemon: pokemon, attribute: "attack")
                BarChartView(pokemon: pokemon, attribute: "defense")
            }
            .padding(20)
        }
    }
    
    var heightToString: String {
        guard let height = pokemon?.height else { return "" }
        let m = (Double(height) / 10.0)
        let ft = m * 3.281
        return String(format: "%.2f m (%.2f ft)", m, ft)
    }
    
    
    var weightToString: String {
        guard let weight = pokemon?.weight else { return "" }
        let kg = (Double(weight) / 10.0)
        let lbs = kg * 2.205
        return String(format: "%.2f kg (%.2f lbs)", kg, lbs)
    }
}


struct BarChartView: View {
    
    @State var pokemon: Pokemon?
    
    let attribute: String
    
    let capsuleWidth = CGFloat(180)
    let capsuleHeight = CGFloat(10)
    
    @State  private var offset: CGFloat = 0
    
    var body: some View {
        HStack {
            Text(attribute.capitalized)
                .bold()
                .frame(width: 70)
                .padding(.trailing, 10)
                .foregroundColor(Color(.systemGray))
            
            Text("\(value)")
                .bold()
                .frame(width: 30)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: capsuleWidth, height: capsuleHeight)
                    .foregroundColor(Color(.systemGray5))
                
                Capsule()
                    .frame(width: offset, height: capsuleHeight)
                    .foregroundColor(attribute == "attack" ? .red : .blue)
                    .scaleEffect(x: barChartValue / capsuleWidth, anchor: .leading)
                    .onAppear {
                        offset = barChartValue
                    }
                    .animation(.easeInOut(duration: 1.0).delay(1), value: self.offset)
            }
        }
    }
    
    var value: String {
        var val: Int
        
        if attribute == "attack" {
            val = pokemon?.stats?
                .filter { $0.stat.name == "attack" }
                .map { $0.baseStat }
                .first ?? 0
        } else if attribute == "defense" {
            val = pokemon?.stats?
                .filter { $0.stat.name == "defense" }
                .map { $0.baseStat }
                .first ?? 0
        } else {
            val = 0
        }
        
        return "\(val)"
    }
    
    var barChartValue: CGFloat {
        let MAX_VALUE = 120.0
        
        var val = Double(value)!
        if val > 120 {
            val = 120
        }
        
        return CGFloat(val / MAX_VALUE * capsuleWidth)
    }
}
