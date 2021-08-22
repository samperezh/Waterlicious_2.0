//
//  ContentView.swift
//  Waterlicious 2.0
//
//  Created by Samantha Perez on 2021-08-21.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    func signOut(){
       try? auth.signOut()
        
        self.signedIn = false
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                ZStack{
                    Color(red: 0.85, green: 0.93, blue: 1.0).ignoresSafeArea()
                    
                    VStack (spacing: 0){
                        
                        HStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                            
                            Spacer()
                            
                            Button(action: {
                            }, label: {
                                Text("Menu")
                                    .frame(width: 70, height: 50)
                                    .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                                    .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                                    .padding()
                                    
                            })
                        }
                    
                        
                        Text("Drink in...")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                            .multilineTextAlignment(.center)
                        
                        Image("Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                        Text("4:59")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.signOut()
                        }, label: {
                            Text("Sign Out")
                                .frame(width: 200, height: 50)
                                .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                                .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                                
                        })
                        Spacer()
                        
                    }
                    
                }
                
               
            }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}
    
    struct SignInView: View {
        
        @State var email = ""
        @State var password = ""
        
        @EnvironmentObject var viewModel: AppViewModel
        
        init(){
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:  UIColor(named: "TextColor") ?? Color.black]
        }
        
        var body: some View {
            ZStack{
                Color(red: 0.85, green: 0.93, blue: 1.0).ignoresSafeArea()
                
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    
                    VStack {
                        Text("WATERLICIOUS")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        TextField("Email Address", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                        
                        SecureField("Password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                        Button(action: {
                            
                            guard !email.isEmpty, !password.isEmpty else {
                                return
                            }
                            
                            viewModel.signIn(email: email, password: password)
                            
                        }, label: {
                            Text("Sign in")
                                .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                                .frame(width: 200, height:50)
                                .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                                .cornerRadius(8)
                        })
                        
                        NavigationLink("Create Account", destination: SignUpView())
                            .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                            .padding()
                    }
                    .padding()
                    
                    Spacer()
                    
                }
                .navigationTitle("Sign in")
                
                    
                
            }
        
        }
    }
    
struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack{
            Color(red: 0.85, green: 0.93, blue: 1.0).ignoresSafeArea()
            
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack {
                    
                    Text("WATERLICIOUS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color(red: 0.38, green: 0.64, blue: 0.76, opacity: 1.0))
                            .frame(width: 200, height:50)
                            .background(Color(red: 0.93, green: 0.97, blue: 1.0, opacity: 1.0))
                            .cornerRadius(8)
                    })
                }
                
                .padding()
                
                Spacer()
                
            }
            .navigationTitle("Create Account")
            
        }
        
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

