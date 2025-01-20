//
//  HomeView.swift
//  LoginApp
//
//  Created by Ahmet Bostancıklıoğlu on 20.01.2025.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 500, height: 200)
                .foregroundStyle(.yellow)
                .opacity(0.4)
                .offset(x: 200, y: -340)
            
            VStack {
                Text("Logged successfully")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                    .padding()
                
                Button {
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                } label: {
                    Text("LogOut")
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                }
            }
            Circle()
                .frame(width: 500, height: 200)
                .foregroundStyle(.yellow)
                .opacity(0.4)
                .offset(x: -200, y: 380)
        }
    }
}

#Preview {
    HomeView()
}
