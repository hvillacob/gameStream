//
//  SaveData.swift
//  GameStream
//
//  Created by Raul Mantilla on 25/01/22.
//

import Foundation

class SaveData {
    var mail: String = ""
    var password: String = ""
    var name: String = ""
    
    func guardarDatos(mail:String, password:String, name:String) -> Bool {
        
        print("Dentro de la funcion guardar datos obtuve: \(mail) + \(password) + \(name)")
        
        UserDefaults.standard.set([mail, password, name], forKey: "userData")
        
        return true
        
    }
    
    func getData() -> [String] {
        let userData: [String] = UserDefaults.standard.stringArray(forKey: "userData")!
        
        print("Estoy en el metodo recuperar datos y recuperé: \(userData)")
        
        return userData
    }
    
    func validate(mail:String, password:String) -> Bool {
        var savedMail = ""
        var savedPassword = ""
        
        print("Estoy revisando si tengo datos en userDefaults con el correo \(mail) y la contraseña \(password)")
        
        if UserDefaults.standard.object(forKey: "userData") != nil {
            
            savedMail = UserDefaults.standard.stringArray(forKey: "userData")![0]
            
            savedPassword = UserDefaults.standard.stringArray(forKey: "userData")![1]
            
            print("El correo guardado es: \(savedMail) y la contraseña guardada es \(savedPassword)")
            
            if(mail == savedMail && password == savedPassword){
                return true
            }else{
                return false
            }
            
            
        }else{
            
            print("No hay datos de usuario guardados en el userDefault")
            
            return false
            
        }
    }
}
