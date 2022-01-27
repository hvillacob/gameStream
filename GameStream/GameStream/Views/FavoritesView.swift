//
//  FavoritesView.swift
//  GameStream
//
//  Created by Raul Mantilla on 24/01/22.
//

import SwiftUI
import AVKit

struct FavoritesView: View {
    
    @ObservedObject var allTheGames = ViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("Marine").ignoresSafeArea()
            VStack {
                
                Text("Tus Favoritos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 9)
                
                ScrollView{
                    
                    ForEach(allTheGames.gamesInfo, id: \.self){
                        
                        game in
                        
                        VStack(spacing: 0) {
                            VideoPlayer(player: AVPlayer(url: URL(string: game.videosUrls.mobile)!))
                                .frame(height: 300)
                            
                            Text("\(game.title)")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("Dark-Blue"))
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                        
                        
                    }
                    
                }.padding(.bottom, 8)
                
            }.padding(.horizontal, 6)
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
