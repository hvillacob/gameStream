//
//  ViewModel.swift
//  GameStream
//
//  Created by Raul Mantilla on 21/01/22.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var gamesInfo = [Game]()
    
    init() {
        
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do{
                
                if let jsonData = data {
                    
                    print("Tamaño del JSON \(jsonData)")
                    
                    
                    let decodeData = try
                        JSONDecoder().decode([Game].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        
                        self.gamesInfo.append(contentsOf: decodeData)
                        
                    }
                    
                }
                
            }catch{
                
                print("Error: \(error)")
                
            }
            
        }.resume()
        
    }
    
}
