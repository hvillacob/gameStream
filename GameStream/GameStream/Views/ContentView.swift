//
//  ContentView.swift
//  GameStream
//
//  Created by Raul Mantilla on 19/01/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            ZStack {
                
                Spacer()
                
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
                    }.padding(.bottom, 42)
                    
                    LogInAndSignInView()
                    
                }
                
            }
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear(){
            UINavigationBar.appearance().tintColor = UIColor.clear
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "chevron.left")?.withTintColor(UIColor(.white)).withRenderingMode(.alwaysOriginal)
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.left")?.withTintColor(UIColor(.white)).withRenderingMode(.alwaysOriginal)

        }
        
        
    }
}


struct LogInAndSignInView: View {
    
    @State var typeLogIn = true
    
    var body: some View{
        
        VStack{
            
            HStack {
                
                Spacer()
                Button(action: {typeLogIn = true}, label: {
                    Text("INICIA SESIÓN")
                })
                .foregroundColor(typeLogIn ? .white : .gray)
                
                
                Spacer()
                
                Button(action: {typeLogIn = false}, label: {
                    Text("REGÍSTRATE")
                })
                .foregroundColor(typeLogIn ? .gray : .white)
                Spacer()
                
            }
            
            Spacer(minLength: 42)
            
            if typeLogIn == true {
                
                LogInView()
                
            }else{
                
                SignInView()
                
            }
            
        }
        
    }
}


struct LogInView: View {
    
    @State var email = ""
    @State var password = ""
    @State var isHomeViewActive = false
    @State var ifUserNotFound = false
    var body: some View{
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                Text("Correo electrónico")
                    .foregroundColor(Color("Dark-Cian"))
                
                ZStack(alignment: .leading){
                    
                    if email.isEmpty{
                        Text("ejemplo@gmail.com").font(.caption).foregroundColor(.gray)
                    }
                    
                    TextField("", text: $email).foregroundColor(.white)
                    
                }
                
                Divider().frame(height: 1).background(Color("Dark-Cian")).padding(.bottom)
                
                Text("Contraseña")
                    .foregroundColor(Color(.white))
                
                ZStack(alignment: .leading){
                    
                    if password.isEmpty{
                        Text("Escribe tu contraseña").font(.caption).foregroundColor(.gray)
                    }
                    
                    SecureField("", text: $password).foregroundColor(.white)
                    
                }
                
                Divider().frame(height: 1).background(Color("Dark-Cian")).padding(.bottom)
                
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(width: 350, alignment: .trailing)
                    .foregroundColor(Color("Dark-Cian"))
                    .padding(.bottom)
                
                
                Button(action: logIn, label: {
                    Text("INICIAR SESIÓN")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("Dark-Cian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
                }).alert(isPresented: $ifUserNotFound, content: {
                    Alert(title: Text("Error"), message: Text("Usuario o contraseña incorrecta"), dismissButton: .default(Text("Ok")))
                })
                
                
                VStack{
                    
                    Text("Inicia sesión con redes sociales").foregroundColor(.white).padding(.top, 50)
                    
                    HStack{
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color("Dark-Blue"))
                            Button(action: {print("iniciando sesión con facebook")}, label: {
                                Link(destination: URL(string: "https://es-la.facebook.com/")!, label: {
                                    Text("Facebook")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, maxHeight: 10, alignment: .center)
                                        .padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                                })
                            })
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color("Dark-Blue"))
                            Button(action: {print("iniciando sesión con twitter")}, label: {
                                Link(destination: URL(string: "https://twitter.com/?lang=es")!, label: {
                                    Text("Twitter")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, maxHeight: 10,alignment: .center)
                                        .padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                                })
                            })
                        }
                        
                    }.padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                    
                }
                
            }.padding(.horizontal, 77)
            
            NavigationLink(
                destination: Home(),
                isActive: $isHomeViewActive,
                label: {
                    EmptyView()
                })
        }
        
    }
    
    func logIn() {
        let objectDataUpdater = SaveData()
        let result = objectDataUpdater.validate(mail: self.email, password: self.password)
        
        print("Mi correo es \(email) y mi contraseña es \(password)")
        
        if result == true {
            ifUserNotFound = false
            isHomeViewActive = true
        }else {
            ifUserNotFound = true
        }
        
        
    }
}


struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var passwordIsNotConfirmed = false
    @State var isHomeViewActive = false
    
    var body: some View{
        
        ScrollView {
            
            VStack(alignment: .center){
                
                Text("Elije una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Puedes cambiar o elegirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: shotPhoto, label: {
                    ZStack {
                        Image("30-swiftui-apps-ios-profile-pic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        Circle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.black)
                            .opacity(0.3)
                        Image(systemName: "camera").foregroundColor(.white)
                    }
                })
                .padding(.bottom)
            }
            
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading){
                    
                    Text("Correo electrónico*")
                        .foregroundColor(Color("Dark-Cian"))
                    
                    ZStack(alignment: .leading){
                        
                        if email.isEmpty{
                            Text("ejemplo@gmail.com").font(.caption).foregroundColor(.gray)
                        }
                        
                        TextField("", text: $email).foregroundColor(.white)
                        
                    }
                    
                    Divider().frame(height: 1).background(Color("Dark-Cian")).padding(.bottom)
                    
                    Text("Contraseña*")
                        .foregroundColor(Color(.white))
                    
                    ZStack(alignment: .leading){
                        
                        if password.isEmpty{
                            Text("Escribe tu contraseña").font(.caption).foregroundColor(.gray)
                        }
                        
                        SecureField("", text: $password).foregroundColor(.white)
                        
                    }
                    
                    Divider().frame(height: 1).background(Color("Dark-Cian")).padding(.bottom)
                    
                    Text("Confirmar contraseña*")
                        .foregroundColor(Color(.white))
                    
                    ZStack(alignment: .leading){
                        
                        if confirmPassword.isEmpty{
                            Text("Vuelve a escribir tu contraseña").font(.caption).foregroundColor(.gray)
                        }
                        
                        SecureField("", text: $confirmPassword).foregroundColor(.white)
                        
                    }
                    
                    Divider().frame(height: 1).background(Color("Dark-Cian")).padding(.bottom)
                    
                    
                }.frame(minWidth: 350, maxWidth: .infinity, alignment: .center)
                
                
                Button(action: singIn, label: {
                    Text("REGÍSTRATE")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("Dark-Cian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
                })
                .padding(.top, 20)
                .alert(isPresented: $passwordIsNotConfirmed, content: {
                    Alert(title: Text("Error"), message: Text("La contraseña no coincide. Confirma tu contraseña"), dismissButton: .default(Text("Ok")))
                })
                
                VStack{
                    
                    Text("Registrate con redes sociales").foregroundColor(.white).padding(.top, 50)
                    
                    HStack{
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color("Dark-Blue"))
                            Button(action: {print("registrandome con facebook")}, label: {
                                Text("Facebook")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 10, alignment: .center)
                                    .padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                            })
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color("Dark-Blue"))
                            Button(action: {print("registrandome con twitter")}, label: {
                                Text("Twitter")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 10,alignment: .center)
                                    .padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                            })
                        }
                        
                    }.padding(EdgeInsets(top: 13, leading: 18, bottom: 11, trailing: 18))
                    
                }
                
            }.padding(.horizontal, 77)
        }
        
    }
    
    func shotPhoto(){
        print("Voy a tomar una foto para el perfil")
    }

    
    func singIn(){
        print("Estoy registrandome")
        
        if  password != confirmPassword {
            passwordIsNotConfirmed = true
        }else{
            passwordIsNotConfirmed = false
        }
        
        let objectDataUpdater = SaveData()
        
        let result = objectDataUpdater.guardarDatos(mail: self.email, password: self.password, name: "NewUser")
        
        isHomeViewActive = true
        print("Se guardaron los datos con exito? \(result)")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        //Image("04_swiftui-apps-ios-pantalla1")
        Image("04_swiftui-apps-ios-pantalla2")
    }
}
