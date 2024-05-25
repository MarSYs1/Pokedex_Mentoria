import SwiftUI

struct TrainerView: View {
    @Binding public var trainer: String
    
    var body: some View {
        ScrollView {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -100)
                    .padding(.bottom, -100)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .center) {
                        Image("cover")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(12)
                        
                        Image("Author")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 190)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(.systemGray6),lineWidth: 4))
                            .offset(y: -110)
                            .padding(.bottom, -110)
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("Fulvio")
                                .font(.title)
                                .bold()
                                .padding(.bottom, 1)
                        }
                    }
                    
                    Text("Change your trainer's name:")
                        .padding(.top, 8)
                    
                    HStack(alignment: .bottom) {
                        TextField("Enter your trainer's name", text: $trainer)
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
                            .background(Color(.systemIndigo))
                            .cornerRadius(4)
                            .padding(.top, -14)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            trainer = ""
                        }, label: { Image(systemName: "clear.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(.systemGray2))
                        })
                    }
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("👨‍💻 Author")
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 1)
                        
                        Text(info["author"]!)
                            .lineLimit(nil)
                            .padding(.bottom, 12)
                        
                        Text("🚀 About this app")
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 1)
                        
                        Text(info["about"]!)
                            .lineLimit(nil)
                            .frame(height: 140)
                            .padding(.bottom, 12)
                        
                        Text("🤔 \"Fulvio?\"")
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 1)
                        
                        Text(info["fulvio"]!)
                            .lineLimit(nil)
                            .frame(height: 50)
                            .padding(.bottom, 12)
                        
                        Text("🌟 Connecting")
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 1)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image("linkedin")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .opacity(0.8)
                                
                                Text("Linkedin")
                                    .underline()
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 1)
                                    .onTapGesture {
                                        if let url = URL(string: info["linkedin"]!) {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                            }
                        }
                        .padding(.bottom, 50)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

var info = [
    "author": "Hi my name is Fulvio and I love building new things using Swift.",
    "about": "This is a full-fledged Pokedex app, built with Swift 5.1 and SwiftUI 3 and targeted at iOS > 15.5. It has all the core functionalities such as search by name or ID. You can also add Pokemons to your Favorite List, up to 6 of them (following the original gameplay).",
    "fulvio": "\"Fulvio\" for most of the games I play.",
    "linkedin": "https://www.linkedin.com/in/fulvio-dev-mobile-ios-swift/",
]
