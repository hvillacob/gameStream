//
//  EditProfileView.swift
//  GameStream
//
//  Created by Raul Mantilla on 24/01/22.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var profileImage: Image! = Image("30-swiftui-apps-ios-profile-pic")
    @State var isCameraActive: Bool = false
    
    var body: some View {
        
        ZStack {
            Color("Marine").ignoresSafeArea()
            ScrollView {
                
                VStack(alignment: .center) {
                    
                    Text("Editar perfil")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.white))
                        .padding(.bottom, 40)
                    
                    Button(action: {isCameraActive = true}, label: {
                        
                        ZStack {
                            profileImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                                .clipShape(Circle())
                                .sheet(isPresented: $isCameraActive, content: {
                                    SUImagePickerView(sourceType: .camera, image: self.$profileImage, isPresented: $isCameraActive)
                                })
                            
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                        }
                        
                    })
                    
                }.padding(.bottom, 18)
                
                ModuleEdit()
                
                Spacer()
                
            }
        }
//        .navigationBarHidden(true)
//        .navigationBarItems(leading: buttonBack)
        
        
    }
}

struct ModuleEdit: View {
    
    @State var mail: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    
    var body: some View{
        
        VStack(alignment: .leading) {
            
            Text("Correo electrónico")
                .fontWeight(.bold)
                .foregroundColor(Color("Dark-Cian"))
            
            ZStack(alignment: .leading){
                
                if mail.isEmpty {
                    
                    Text("ejemplo@gmail.com")
                        .font(.caption)
                        .foregroundColor(Color("Light-Gray"))
                }
                
                TextField("", text: $mail)
                    .foregroundColor(.white)
                
            }
            
            Divider()
                .frame(height: 1)
                .background(Color("Dark-Cian"))
            
            Text("Contraseña")
                .fontWeight(.bold)
                .foregroundColor(Color(.white))
            
            ZStack(alignment: .leading){
                
                if password.isEmpty {
                    
                    Text("Introduce tu nueva contraseña")
                        .font(.caption)
                        .foregroundColor(Color("Light-Gray"))
                }
                
                SecureField("", text: $password)
                    .foregroundColor(.white)
                
            }
            
            Divider()
                .frame(height: 1)
                .background(Color("Light-Gray"))
            
            Text("Nombre")
                .fontWeight(.bold)
                .foregroundColor(Color(.white))
            
            ZStack(alignment: .leading){
                
                if userName.isEmpty {
                    
                    Text("Introduce tu nombre de usuario")
                        .font(.caption)
                        .foregroundColor(Color("Light-Gray"))
                }
                
                TextField("", text: $userName)
                    .foregroundColor(.white)
                
            }
            
            Divider()
                .frame(height: 1)
                .background(Color(.white))
                .padding(.bottom, 32)
            
            Button(action: {updateData()}, label: {
                
                Text("ACTUALIZAR DATOS")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("Dark-Cian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
                
            }).padding(.bottom)

            
        }.padding(.horizontal, 42)
        
    }
    
    func updateData() {
        
        let objectDataUpdater = SaveData()
        
        let result = objectDataUpdater.guardarDatos(mail: mail, password: password, name: userName)
        
        print("Se guardaron los datos con exito ? \(result)")
        
        
        
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
