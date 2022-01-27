//
//  GamesView.swift
//  GameStream
//
//  Created by Raul Mantilla on 21/01/22.
//

import SwiftUI
import Kingfisher

struct GamesView: View {
    
    @ObservedObject var allTheGames = ViewModel()
    
    @State var gameViewIsActive: Bool = false
    @State var url: String = ""
    @State var title: String = ""
    @State var calification: String = ""
    @State var studio: String = ""
    @State var yearPublication: String = ""
    @State var descrip: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    var gridForm: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    
    
    var body: some View {
        
        ZStack{
                
            Color("Marine")
                .ignoresSafeArea()
            
            VStack{
                
                Text("Juegos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{

                    LazyVGrid(columns: gridForm, spacing: 8){
                        
                        ForEach(allTheGames.gamesInfo, id: \.self){
                            
                            game in
                            

                                Button(action: {
                                
                                    url = game.videosUrls.mobile
                                    title = game.title
                                    studio = game.studio
                                    calification = game.contentRaiting
                                    yearPublication = game.publicationYear
                                    descrip = game.description
                                    tags = game.tags
                                    imgsUrl = game.galleryImages
                                
                                    print("pulse el juego \(title)")
                                
                                    gameViewIsActive = true
                                
                                
                                }, label: {
                                
                                    VStack {
                                        KFImage(URL(string: game.galleryImages[0]))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 173, maxHeight: 99)
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                            .padding(.bottom, 12)
                                        Text(game.title)
                                            .lineLimit(1)
                                    }
                                
                                })
                        }
                        
                    }
                    
                }
                
            }.padding(.horizontal, 6)
            
            NavigationLink(
                destination: GameView(url: url, title: title, studio: studio, calification: calification, publicationYear: yearPublication, description: descrip, tags: tags, imgsUrl: imgsUrl),
                isActive: $gameViewIsActive,
                label: {
                    EmptyView()
                })
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
            .onAppear(
            
                perform: {
                    
                    if let firtsVideo =
                        allTheGames.gamesInfo.first{
                        print("primer elemento del JSON: \(firtsVideo)")
                        print("titulo del primer juego del JSON \(firtsVideo.title)")
                    } else{
                        print("no se encontraron videos")
                    }
                }
                
            
            )
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
