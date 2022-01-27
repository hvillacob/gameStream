//
//  GameView.swift
//  GameStream
//
//  Created by Raul Mantilla on 24/01/22.
//

import SwiftUI
import AVKit
import Kingfisher

struct GameView: View {
    
    var url: String
    var title: String
    var studio: String
    var calification: String
    var publicationYear: String
    var description: String
    var tags: [String]
    var imgsUrl: [String]
    
    
    var body: some View {
        
        ZStack {
            
            Color("Marine")
                .ignoresSafeArea()
            
            VStack{
                
                
                
                ScrollView{
                    
                    video(url: url).frame(height: 300)
                    
                    // Informacion del video
                    videoInfo(title: title, studio: studio, calification: calification, publicationYear: publicationYear, description: description, tags: tags)
                        .padding(.bottom)
                    
                    Gallery(imgsUrl: imgsUrl)
                    
                    CommentView(CommentViewObject(userName: "pepito perez", days: 12, description: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.", avatarUrl: "https://pbs.twimg.com/media/E9sN5jzVUAUgYHn.png"))
                    
                    CommentView(CommentViewObject(userName: "pepito perez", days: 12, description: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.", avatarUrl: "https://pbs.twimg.com/media/E9sN5jzVUAUgYHn.png"))
                    
                    SimilarGamesView()
                    
                }.frame(maxWidth: .infinity)
                
            }
        }
        
    }
}

struct video: View {
    
    var url: String
    
    var body: some View{
        
        VideoPlayer(player: AVPlayer(url: URL(string: url)!)).ignoresSafeArea()
        
    }
}

struct videoInfo: View {
    
    var title: String
    var studio: String
    var calification: String
    var publicationYear: String
    var description: String
    var tags: [String]
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            Text("\(title)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(.leading)
            
            HStack{
                
                Text("\(studio)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                    .padding(.leading)
                
                Text("\(calification)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                
                Text("\(publicationYear)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                
            }
            
            Text("\(description)")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 5)
                .padding(.leading)
            
            HStack{
                
                ForEach(tags, id: \.self){
                    
                    tag in
                    
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top, 4)
                        .padding(.leading)
                    
                }
                
            }
            
        }.frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct Gallery: View {
    
    var imgsUrl: [String]
    let formGrid = [
    
        GridItem(.flexible())
        
    ]
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            Text("GALERÍA")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            
            ScrollView(.horizontal){
                
                LazyHGrid(rows: formGrid, spacing: 8){
                    
                    ForEach(imgsUrl, id: \.self){
                        
                        imgUrl in
                        
                        // Desplegar imagenes del servidor por medio de URL
                        KFImage(URL(string: imgUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    }
                    
                }
                
            }.frame(height: 180)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct CommentViewObject: Hashable {
    let userName: String
    let days: UInt
    let description: String
    let avatarUrl: String
    
    init(userName: String,
         days: UInt,
         description: String,
         avatarUrl: String) {
        self.userName = userName
        self.days = days
        self.description = description
        self.avatarUrl = avatarUrl
    }
}

struct CommentView: View {
    
    let commentVO: CommentViewObject
    
    init(_ commentVO: CommentViewObject) {
        self.commentVO = commentVO
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("blue_gray"))
            VStack {
                HStack(alignment: .top){
                    KFImage(URL(string: commentVO.avatarUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text(commentVO.userName)
                            .foregroundColor(.white)
                            .bold()
                            .font(.subheadline)
                            .padding(.bottom, 1)
                        Text("Hace \(commentVO.days) días")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    Spacer()
                }
                Text(commentVO.description)
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(.top, 8)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minHeight: 0, maxHeight: .infinity, alignment: .leading)
                Spacer()
            }.padding(15)
        }
    }
}

struct SimilarGamesView: View {
    var body: some View{
        Text("JUEGOS SIMILARES")
            .font(.title3)
            .foregroundColor(.white)
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false){

            HStack{
                
                Button(action: {
                }, label: {
                    
                    Image("cup-head")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                })
                
                Button(action: {
                }, label: {
                    
                    Image("hades")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                })
                
                Button(action: {
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(
            url: "ejemplo",
            title: "Sonic The Hedgehog",
            studio: "Sega",
            calification: "E+",
            publicationYear: "1991",
            description: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente",
            tags: ["plataformas","mascota"],
            imgsUrl: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"
            ])
    }
}
