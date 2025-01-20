import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    // MARK: Properties
    @State var email = ""
    @State var name = ""
    @State var pass = ""
    @State var visible = false
    @State var color = Color.black.opacity(0.7)
    @Environment(\.dismiss) private var dismiss
    @State var error = ""
    @State var alert = false
    @Binding var show : Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Circle()
                    .frame(width: 500, height: 200)
                    .foregroundStyle(.yellow)
                    .opacity(0.4)
                    .offset(x: 200, y: -340)
                
                VStack {
                    Spacer(minLength: 100)
                    VStack {
                        Text("Create Account")
                            .font(.title)
                            .bold()
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Full Name")
                                .padding(.horizontal, 80)
                            
                            TextField("Enter your name", text: $name)
                                .textInputAutocapitalization(.none)
                                .padding()
                                .background(.gray.opacity(0.1))
                                .cornerRadius(15)
                                .padding(.horizontal, 60)
                                .padding()
                            
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
                                            
                                    } else {
                                        SecureField("Enter your password", text: $pass)
                                            
                                    }
                                }
                                .textInputAutocapitalization(.none)
                                
                                Button(action: {self.visible.toggle() }) {
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundStyle(self.color)
                                }
                            }
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(15)
                            .padding(.horizontal, 60)
                            .padding()
                            
                            Button {
                                self.register()
                            } label: {
                                Text("Create An Account")
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
                                Button {
                                    self.dismiss()
                                } label: {
                                    Text("Back To ")
                                        .foregroundStyle(.gray)
                                        .fontWeight(.semibold)
                                    Text("Sign In")
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
                    .offset(x: -200, y: 380)
            }
        }
    }
    
    func register() {
        if self.email != "" && self.name != "" && self.pass != "" {
            Auth.auth().createUser(withEmail: self.email, password: self.pass) { result, error in
                if let error = error {
                    self.error = error.localizedDescription
                    self.alert.toggle()
                    return
                }
            }
        } else {
            self.error = "Please fill all the contains properly"
            self.alert.toggle()
        }
    }
}
//
//#Preview {
//    RegisterView()
//}
