//
//  Home.swift
//  GameStream
//
//  Created by Raul Mantilla on 20/01/22.
//

import SwiftUI
import AVKit

struct Home: View {
    
    @State var tabSelected: Int = 2
    
    var body: some View {
        
        TabView(selection: $tabSelected){
            
            HomeScreen()
                .tabItem {
                Image(systemName: "house")
                Text("Inicio")
                }.tag(2)
            
            GamesView()
                .tabItem {
                Image(systemName: "gamecontroller")
                Text("Juegos")
                }.tag(1)
            
            FavoritesView()
                .tabItem {
                Image(systemName: "heart")
                Text("Favoritos")
                }.tag(3)
            
            ProfileView()
                .tabItem {
                Image(systemName: "person")
                Text("Perfil")
                }.tag(0)
            
        }.accentColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color("TabBar-Color"))
        UITabBar.appearance().isTranslucent = true
        
        print("Iniciando las vistas de home")
    }
    
}

struct HomeScreen: View {
    
    @State var seachText = ""
    
    var body: some View{
        
        ZStack{
            
            Color("Marine").ignoresSafeArea()
            VStack{
                
                HStack{
                    Image("04_swiftui-apps-ios-logo-game").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    Image("04_swiftui-apps-ios-logo-name")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                }.padding(.horizontal, 11)
                
                
                
                SubModuleHome()
                
            }.padding(.horizontal, 18)
            
            
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
        
        
    }
    
    
    
}

struct SubModuleHome: View {
    
        @State var isGameInfoEmpty = false
        @State var seachText = ""
    
        @ObservedObject var gameFound = SearchGame()
        @State var isGameViewActive = false
    
        @State var url: String = ""
        @State var title: String = ""
        @State var calification: String = ""
        @State var studio: String = ""
        @State var yearPublication: String = ""
        @State var descrip: String = ""
        @State var tags: [String] = [""]
        @State var imgsUrl: [String] = [""]
    

    var body: some View {

        VStack{
            
            ScrollView{
                
                HStack{
                    
                    Button(action: {
                        watchGame(name: seachText)
                        
                    }, label: {
                        Image(systemName: "magnifyingglass").foregroundColor(seachText.isEmpty ? Color(.white) : Color("Dark-Cian"))
                    }).alert(isPresented: $isGameInfoEmpty){
                        
                        Alert(title: Text("Error"), message: Text("No se encontró el juego"), dismissButton: .default(Text("Entendido")))
                        
                    }
                    
                    ZStack(alignment: .leading){
                        
                        if seachText.isEmpty {
                            Text("Buscar un video").foregroundColor(Color(red: 174/255, green: 177/255, blue: 185/255, opacity: 1.0))
                        }
                        TextField("", text: $seachText).foregroundColor(.white)
                        
                    }
                    
                }.padding([.top,  .leading, .bottom], 11)
                .background(Color("Dark-Blue"))
                .clipShape(Capsule())
                
                Text("LOS MÁS POPULARES")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.top)

                ZStack{

                    Button(action: {watchGame(name: "The Witcher 3: Wild Hunt")
                    }, label: {

                        VStack(spacing: 0) {

                            Image("13-swiftuiapps-2105-thewitcher")
                                .resizable()
                                .scaledToFit()

                            Text("The Witcher 3")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .background(Color("Dark-Blue"))

                        }
                    })

                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)

                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .padding(.vertical)
                
                Text("CATEGORÍAS SUGERIDAS PARA TI")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 18)

                ScrollView(.horizontal, showsIndicators: false){

                    HStack{

                        Button(action: {print("shoter")}, label: {
                            
                            ZStack{

                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Dark-Blue"))
                                    .frame(width: 160, height: 90)
                                Image("Vector-shot")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)

                            }

                        })
                        
                        Button(action: {print("Rpg")}, label: {
                            
                            ZStack{

                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Dark-Blue"))
                                    .frame(width: 160, height: 90)
                                Image("rpg-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)

                            }

                        })
                        
                        Button(action: {print("Open worldo")}, label: {
                            
                            ZStack{

                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Dark-Blue"))
                                    .frame(width: 160, height: 90)
                                Image("open-world-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)

                            }

                        })

                    }

                }
                
                Text("RECOMENDADOS PARA TI")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false){

                    HStack{
                        
                        Button(action: {watchGame(name: "abzu")
                        }, label: {
                            
                            Image("abzu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        })
                        
                        Button(action: {watchGame(name: "Crash Bandicoot™ N. Sane Trilogy")
                        }, label: {
                            
                            Image("Crash-Bandicoot")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        })
                        
                        Button(action: {watchGame(name: "Grand Theft Auto V")
                        }, label: {
                            
                            Image("grand-theft-auto")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        })
                        
                    }

                }
                
                Text("VIDEOS QUE PODRÍAN GUSTARTE")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false){

                    HStack{
                        
                        Button(action: {watchGame(name: "Cuphead")
                        }, label: {
                            
                            Image("cup-head")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        })
                        
                        Button(action: {watchGame(name: "Hades")
                        }, label: {
                            
                            Image("hades")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        })
                        
                        Button(action: {watchGame(name: "DEATH STRANDING")
                        }, label: {
                            
                            Image("deathstranding")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        })
                        
                    }

                }
                
            }


        }


        NavigationLink(
            destination: GameView(url: url, title: title, studio: studio, calification: calification, publicationYear: yearPublication, description: descrip, tags: tags, imgsUrl: imgsUrl),
            isActive: $isGameViewActive,
            label: {
                EmptyView()
            })

    }
    
    func watchGame(name: String) {
        
        gameFound.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            
            print("Cantidad E: \(gameFound.gameInfo.count)")
            
            if gameFound.gameInfo.count == 0 {
                
                isGameInfoEmpty = true
                
            }else{
                
                url = gameFound.gameInfo[0].videosUrls.mobile
                title = gameFound.gameInfo[0].title
                studio = gameFound.gameInfo[0].studio
                calification = gameFound.gameInfo[0].contentRaiting
                yearPublication = gameFound.gameInfo[0].publicationYear
                descrip = gameFound.gameInfo[0].description
                tags = gameFound.gameInfo[0].tags
                imgsUrl = gameFound.gameInfo[0].galleryImages
                
                isGameViewActive = true
            }
            
        }
        
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
