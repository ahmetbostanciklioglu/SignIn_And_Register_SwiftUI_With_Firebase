import SwiftUI
import FirebaseAuth


struct LoginView: View {
    // MARK: Properties
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @State var color = Color.black.opacity(0.7)
    @State var alert = false
    @State var error = ""
    @Binding var show : Bool
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Circle()
                    .frame(width: 500, height: 200)
                    .foregroundStyle(.yellow)
                    .opacity(0.4)
                    .offset(x: -200, y: -320)
                
                VStack {
                    Spacer(minLength: 150)
                    VStack {
                        Text("Let's Sign you in")
                            .font(.title)
                            .bold()
                            .padding()
                        

                        VStack(alignment: .leading, spacing: 0) {
                            Text("Email Address")
                                .padding(.horizontal, 80)
                            
                            TextField("Enter your email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(.gray.opacity(0.1))
                                .cornerRadius(15)
                                .padding(.horizontal, 60)
                                .padding()
                            
                            Text("Password")
                                .padding(.horizontal, 80)
                            
                            HStack {
                                VStack {
                                    if self.visible {
                                        TextField("Enter your password", text: self.$pass)
                                            .textInputAutocapitalization(.none)
                                    } else {
                                        SecureField("Enter your password", text: $pass)
                                            .textInputAutocapitalization(.none)
                                    }
                                }
                                
                                Button {
                                    self.visible.toggle()
                                } label: {
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundStyle(self.color)
                                }
                            }
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(15)
                            .padding(.horizontal, 60)
                            .padding()
                            
                            HStack {
                                Spacer()
                                Button {
                                    self.reset()
                                } label: {
                                    Text("Forgot Password")
                                        .foregroundStyle(.red)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal, 80)
                            }
                            
                            Button {
                                self.verify()
                            } label: {
                                Text("Sign In")
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                                    .frame(width: 380, height: 50)
                                    .background(.yellow)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 60)
                            }
                            .padding()
                        }
                        VStack {
                            HStack {
                                NavigationLink{
                                    RegisterView(show: $show)
                                } label:  {
                                    Text("Don't have an Account? ")
                                        .foregroundStyle(.gray)
                                        .fontWeight(.semibold)
                                    Text("Sign Up")
                                        .foregroundStyle(.yellow)
                                        .fontWeight(.semibold)
                                        .cornerRadius(10)
                                }
                            }
                            .multilineTextAlignment(.center)
                            .padding()
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
                if self.alert {
                    ErrorView( alert: self.$alert, error: self.$error)
                        .offset(x: 65)
                }
                Circle()
                    .frame(width: 500, height: 200)
                    .foregroundStyle(.yellow)
                    .opacity(0.4)
                    .offset(x: 200, y: 400)
            }
        }
        .tint(.yellow)
    }
    
    func verify() {
        if self.email != "" && self.pass != "" {
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { result, error in
                if let error = error {
                    self.error = error.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("success")
                
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        } else {
            self.error = "Please fill in all fields correctly."
            self.alert.toggle()
        }
    }
    
    
    func reset() {
        if self.email != "" {
            Auth.auth().sendPasswordReset(withEmail: self.email) { error in
                if error != nil {
                    self.error = error!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.error = "RESET"
                self.alert.toggle()
            }
        } else {
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
}
//
//#Preview {
//    LoginView()
//}
