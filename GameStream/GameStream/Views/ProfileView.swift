//
//  ProfileView.swift
//  GameStream
//
//  Created by Raul Mantilla on 24/01/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var userName = "Alopencio"
    @State var profileImage: UIImage = UIImage(named: "30-swiftui-apps-ios-profile-pic")!
    
    var body: some View {
        
        ZStack {
            
            Color("Marine").ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Perfil")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .center).padding()
                    
                    VStack{
                        
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 118, height: 118)
                            .clipShape(Circle())
                            .rotationEffect(.degrees((90)))
                        
                        Text(userName)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.subheadline)
                        
                    }.padding(EdgeInsets(top: 20, leading: 0, bottom: 32, trailing: 0))
                    
                    Text("Ajustes")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .leading).padding(.leading, 18)
                    
                    ModuleSettings()
                }
            }
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear(
        
            perform: {
                
                if returnUiImage(named: "fotoperfil") != nil {
                    
                    profileImage = returnUiImage(named: "fotoperfil")!
                    
                }else{
                    print("No encontre foto de perfil guardada en el dispositivo")
                }
                
                print("Revisando informacion del usuario para ver si existe")
                
                if UserDefaults.standard.stringArray(forKey: "userData") != nil {
                    
                    userName = UserDefaults.standard.stringArray(forKey: "userData")![2]
                }
                
            }
            
        )
        
    }
    
    func returnUiImage(named: String) -> UIImage? {
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
}

struct ModuleSettings: View {
    
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    
    var body: some View{
        
        VStack {
            Button(action: {}, label: {
                
                HStack {
                    Text("Cuenta")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }.padding()
                
            })
            .background(Color("Dark-Blue"))
            .clipShape(RoundedRectangle(cornerRadius: 1))
            
            Button(action: {}, label: {
                
                HStack {
                    Text("Notificaciones")
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isToggleOn)
                }.padding()
                
            })
            .background(Color("Dark-Blue"))
            .clipShape(RoundedRectangle(cornerRadius: 1))
            
            Button(action: {isEditProfileViewActive = true}, label: {
                
                HStack {
                    Text("Editar perfil")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }.padding()
                
            })
            .background(Color("Dark-Blue"))
            .clipShape(RoundedRectangle(cornerRadius: 1))
            
            Button(action: {}, label: {
                
                HStack {
                    Text("Califica esta aplicación")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }.padding()
                
            })
            .background(Color("Dark-Blue"))
            .clipShape(RoundedRectangle(cornerRadius: 1))
            
            NavigationLink(
                destination: EditProfileView(),
                isActive: $isEditProfileViewActive,
                label: {
                    EmptyView()
                })
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
